class Configzona < ActiveRecord::Base
  attr_accessible :configparametre_id, :svg, :dibuix

  belongs_to :configparametre
  validates_presence_of :configparametre
end