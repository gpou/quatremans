class Cart
  include BillingManipulation

  attr_reader :items
  attr_accessor :invoice_address, :shipment_address, :shipping_amount, :comment

  def initialize
    @items = ActiveSupport::OrderedHash.new
    # TODO
    @shipping_amount = 0
  end

  def item(producte)
#    ActiveRecord::Base.logger.debug "************************************************************"
    if @items.key? producte.id
      @items[producte.id]
    else
      add(producte, 0)
      @items[producte.id]
    end
  end

  def active_items
    active_items = {}
    @items.each do |cart_item_id,cart_item|
      if cart_item.quantity>0
        active_items[cart_item_id] = cart_item
      end
    end
    active_items
  end

  def clear
    initialize
  end

  def add(producte, quantity)
    if @items.key? producte.id
      @items[producte.id].quantity = @items[producte.id].quantity.to_i + quantity.to_i
    else
      @items[producte.id] = CartItem.new(producte, quantity)
    end
  end

  def update_item(producte, data, quantity_to_add = 0)
    if @items.key? producte.id
      @items[producte.id].update(data, quantity_to_add)
    end
  end

  def update_cart cart
    if cart[:items].present?
      cart[:items].each do |item|
        self.update(Item.find(item[0]), item[1][:quantity])
      end
    end
    if cart[:shipment_address].present?
      @shipment_address = cart[:shipment_address]
    end
    if cart[:invoice_address].present?
      @invoice_address = cart[:invoice_address]
    end
  end

  def calculate_shipping_amount
    @shipping_amount = shipment_address.provincia.preu_ports
  end

  def remove(producte)
    begin
      @items.delete producte.id
    rescue NoMethodError
      raise 'No item found on Cart.remove'
    end
  end

  def items_amount
    sum = 0
    @items.each do |cart_item_id,cart_item|
      sum += cart_item.line_price 
    end
    sum
  end

  def total_amount
    items_amount + (shipping_amount || 0)
  end

end
