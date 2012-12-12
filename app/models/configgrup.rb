class Configgrup < ActiveRecord::Base
  attr_accessible :nom, :tipus, :coleccio_id, :configopcio_ids

  has_and_belongs_to_many :configopcions
  belongs_to :coleccio

  scope :teixit, :conditions => ["tipus = ?","teixit"]
  scope :estampat, :conditions => ["tipus = ?","estampat"]
  scope :nina, :conditions => ["tipus = ?","nina"]
  scope :vestit_nina, :conditions => ["tipus = ?","vestit_nina"]

  def to_label
    self.nom
  end

end