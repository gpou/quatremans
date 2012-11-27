class CartItem
  include ActiveModel::Validations
  include ActiveModel::Conversion  
  extend ActiveModel::Naming  

  attr_reader :id, :nom
  attr_accessor :nom, :comment, :quantity, :unit_price
  validates_presence_of :comment  

  include ItemInLineManipulation


  def initialize(u_producte, quantity, data)
    @id = u_producte.id
    @quantity = quantity
    if data[:comment].present?
      @comment = data[:comment]
    else
      @comment = ""
    end
  end

  def update(data)
    @comment = data[:comment]
  end

  def producte
    Producte.find_by_id(@id)
  end

  def nom
    producte.nom
  end

  def persisted?  
    true  
  end


end