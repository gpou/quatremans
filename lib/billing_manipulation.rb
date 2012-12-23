module BillingManipulation

  def total_taxes_excluded
    total_amount / (1 + vat_rate)
  end

  def total_taxes_included
    items_amount
    #items_array.inject(0) { |sum, item| sum += item.line_price }
  end

  def items_array
    [Hash, ActiveSupport::OrderedHash].include?(self.items.class) ? self.items.values : self.items
  end

  def total_vat
    total_amount - total_taxes_excluded
  end

  def vat_rate
    0.21
    #User.vat_rate
  end
end