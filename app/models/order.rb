# encoding: utf-8
class Order < ActiveRecord::Base

  include BillingManipulation

  belongs_to :user
  has_many :orderitems
  has_many :addresses, :as => :addressable
  has_many :ordertransactions

  belongs_to :paymentmode

  after_create :generate_number

  cattr_accessor :states_in_catalan
  @@states_in_french = { "pending" => "A l'espera", "paid" => "Pagat", "cancelled" => "Anulat", "delivered" => "Enviat"}

  scope :pending, lambda { {:conditions => ["state = ?", 'pending'], :order => ['created_at desc']}}
  scope :paid, lambda { {:conditions => ["state = ?", 'paid'], :order => ['created_at desc']}}

  validates :paymentmode_id, :presence => true

  state_machine :state, :initial => :pending do

    after_transition :on => :deliver, :do => :notify_customer_about_delivering

    event :pay do
      transition [:pending,:cancelled] => :paid
    end

    event :cancel do
      transition :pending => :cancelled
    end

    event :deliver do
      transition :paid => :delivered
    end

    event :close do
      transition [:pending,:cancelled,:paid,:delivered] => :closed
    end
  end

  def save_cart(cart)
    self.amount = cart.total_amount
    self.vat_amount = cart.total_vat
    self.shipping_amount = cart.shipping_amount

    invoice_address = cart.invoice_address.clone
    invoice_address.is_invoice = true
    invoice_address.save
    self.addresses << invoice_address

    shipment_address = cart.shipment_address.clone
    shipment_address.is_invoice = false
    shipment_address.save
    self.addresses << shipment_address

    cart.items.each do |k,v|
      order_item = Orderitem.new
      order_item.label = v.producte.nom
      order_item.producte = v.producte
      order_item.unit_price = v.unit_price
      order_item.quantity = v.quantity
      order_item.save!
      self.orderitems << order_item
      logger.info v.inspect

      v.producte.configparametres.each do |parametre|
        opcio = v.get_parametre_opcio_actual(parametre.id)
        param = Orderitemparametre.new
        param.producte = v.producte
        param.orderitem = order_item
        param.configparametre = parametre
        param.configopcio = opcio
        param.label = parametre.nom
        param.value = opcio.nom
        param.save!
      end

      if v.producte.tipus=='nina'
        Producte.where("coleccio_id = ? AND tipus='model_nina'",v.producte.coleccio.id).each do |subproducte|
          if (v.get_parametre_subproducte(subproducte.id))
            param = Orderitemparametre.new
            param.producte = subproducte
            param.orderitem = order_item
            param.label = subproducte.nom
            param.value = "1"
            param.save!

            subproducte.configparametres.each do |parametre|
              opcio = v.get_parametre_opcio_actual(parametre.id)
              param = Orderitemparametre.new
              param.producte = subproducte
              param.orderitem = order_item
              param.configparametre = parametre
              param.configopcio = opcio
              param.label = parametre.nom
              param.value = opcio.nom
              param.save!
            end            
          end
        end
      end

    end
    self.save!
  end

  def items_amount
    orderitems.inject(0) { |sum, item| sum += item.order_line_price }
  end

  def shipment_address
    addresses.shipment.last
  end

  def invoice_address
    addresses.invoice.last
  end

  def self.number_to_currency number
    sprintf("%.2f", number).gsub('.',',')+" €"
  end  

  protected
  def generate_number
    self.number = self.created_at.year.to_s + "00" + id.to_s
    save
  end

  def notify_customer_about_delivering
    #UserMailer.order_delivery_notification(self,customer).deliver
  end
end
