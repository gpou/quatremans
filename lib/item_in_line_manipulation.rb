module ItemInLineManipulation

  def line_price
    if self.available
      self.unit_price*self.quantity.to_f rescue 0
    else
      0
    end
  end

  def order_line_price
    self.unit_price*self.quantity.to_f rescue 0
  end

end