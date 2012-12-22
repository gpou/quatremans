class Provincia < ActiveRecord::Base
  self.table_name = "provincias"
  belongs_to :country
end