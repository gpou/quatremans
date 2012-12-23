class Orderitemparametre < ActiveRecord::Base
  belongs_to :orderitem
  belongs_to :configparametre
  belongs_to :configopcio
  belongs_to :producte
  
end