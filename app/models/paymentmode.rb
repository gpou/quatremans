class Paymentmode < ActiveRecord::Base

  validates :name, :presence => true
  validates :slug, :presence => true
  validates :state, :presence => true

  translates :name, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations

  state_machine :state, :initial => :inactive do
    event :activate do
      transition [:inactive] => :active
    end

    event :inactivate do
      transition [:active] => :inactive
    end
  end
end
