class Orderitem < ActiveRecord::Base

  include ItemInLineManipulation

  belongs_to :order
  belongs_to :producte
  has_many :orderitemparametres

  def get_subproductes
    sub = []
    Producte.where("coleccio_id = ? AND tipus='model_nina'",producte.coleccio.id).each do |subproducte|
      if (get_parametre_subproducte(subproducte.id))
        sub.push subproducte
      end
    end
    sub
  end

end