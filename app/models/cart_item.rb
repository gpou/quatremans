class CartItem
  include ActiveModel::Validations
  include ActiveModel::Conversion  
  extend ActiveModel::Naming  

  attr_reader :id, :nom
  attr_accessor :nom, :quantity, :unit_price, :parametres
  validates_presence_of :comment  

  include ItemInLineManipulation


  def initialize(u_producte, quantity)
    @id = u_producte.id
    @quantity = quantity
    @unit_price = self.producte.preu
  end

  def update(data, quantity_to_add)
    self.parametres = data
    @quantity += quantity_to_add
  end

  def get_parametre(id)
    par = "parametre_"+id.to_s
    if self.parametres && (self.parametres.key? par)
      self.parametres[par].to_i
    else
      Configparametre.find(id).configgrup.configopcions.first.id
    end
  end

  def get_parametre_subproducte(id)
    par = "subproducte_"+id.to_s
    if self.parametres && (self.parametres.key? par)
      self.parametres[par]=="1"
    else
      false
    end
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