class Configzona < ActiveRecord::Base
  attr_accessible :nom, :configparametre_id, :svg, :dibuix, :configurador

  belongs_to :configparametre
  validates_presence_of :configparametre

  scope :dibuixar, :conditions => ["dibuix = ?",true]
  scope :configurar, :conditions => ["configurador = ?",true]

end