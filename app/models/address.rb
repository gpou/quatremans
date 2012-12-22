class Address < ActiveRecord::Base
  belongs_to :addressable, :polymorphic => true
  belongs_to :country
  belongs_to :provincia

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :street, :presence => true
  validates :zip, :presence => true
  validates :city, :presence => true
  validates :country, :presence => true
  validates :provincia, :presence => true
  validates :dni, :presence => true, :if => :is_invoice?
  validate :algun_contacte

  scope :invoice, :conditions => ["is_invoice = ?",true]
  scope :shipment, :conditions => ["is_invoice = ?",false]

  def clone
    Address.new self.attributes.delete_if{ |k,v| %w(id created_at updated_at addressable_id addressable_type).include?(k) }
  end

  def algun_contacte
    errors.add(:phone, :blank) if phone.blank? && email.blank?
  end

end
