class Configparametre < ActiveRecord::Base
  attr_accessible :nom, :tipus, :position, :locale, :producte_id, :configgrup_id, :configopcio_id, :translations_attributes, :configzones_attributes
  #tipus: mostra, estampat, nina, vestit_nina

  translates :nom, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations

  belongs_to :producte
  validates_presence_of :producte
  belongs_to :configgrup
  validates_presence_of :configgrup
  belongs_to :configopcio

  has_many :configzones, :dependent => :destroy
  accepts_nested_attributes_for :configzones, :allow_destroy => true

  acts_as_list :scope => :producte
  default_scope :order => 'position ASC'


  def to_label
    self.nom
  end

  def opcio_defecte
    if self.configopcio && self.configgrup.configopcions.include?(self.configopcio)
      self.configopcio
    else
      nil
    end
  end

end