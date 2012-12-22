class CartItem
  include ActiveModel::Validations
  include ActiveModel::Conversion  
  extend ActiveModel::Naming  

  attr_reader :id, :nom
  attr_accessor :nom, :quantity, :unit_price, :parametres, :available

  include ItemInLineManipulation


  def initialize(u_producte, quantity)
    @id = u_producte.id
    @quantity = quantity
    @unit_price = self.producte.preu
    @available = true
  end

  def update(data, quantity_to_add)
    self.parametres = data
    if @quantity == 0
      @quantity += quantity_to_add
    end
    @unit_price = producte.preu
    if producte.tipus=='nina'
      Producte.where("coleccio_id = ? AND tipus='model_nina'",producte.coleccio.id).each do |subproducte|
        if (get_parametre_subproducte(subproducte.id))
          @unit_price += subproducte.preu
        end
      end
    end
    producte.configparametres.each do |parametre|
      opcio = get_parametre_opcio_actual(parametre.id)
      if opcio.preu
        @unit_price += opcio.preu
      end
    end
  end

  def get_parametre(id)
    par = "parametre_"+id.to_s
    if self.parametres && (self.parametres.key? par)
      self.parametres[par].to_i
    else
      par = Configparametre.find(id)
      par.opcio_defecte ? par.opcio_defecte.id : par.configgrup.configopcions.first.id
    end
  end

  def get_parametre_opcio_actual(id)
    opcio = get_parametre(id)
    Configopcio.find(opcio)
  end

  def get_parametre_subproducte(id)
    par = "subproducte_"+id.to_s
    if self.parametres && (self.parametres.key? par)
      self.parametres[par]=="1"
    else
      false
    end
  end

  def get_subproductes
    sub = []
    Producte.where("coleccio_id = ? AND tipus='model_nina'",producte.coleccio.id).each do |subproducte|
      if (get_parametre_subproducte(subproducte.id))
        sub.push subproducte
      end
    end
    sub
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