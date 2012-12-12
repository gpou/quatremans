class ConfigParametre < ActiveRecord::Base
  attr_accessible :nom, :tipus, :position, :locale, :producte_id, :config_grup_id, :translations_attributes, :config_zones_attributes
  #tipus: mostra, estampat, nina, vestit_nina

  translates :nom, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations

  belongs_to :producte
  validates_presence_of :producte
  belongs_to :config_grup
  validates_presence_of :config_grup

  has_many :config_zones, :dependent => :destroy, :class_name => "ConfigZona"
  accepts_nested_attributes_for :config_zones, :allow_destroy => true

  acts_as_list :scope => :producte
  default_scope :order => 'position ASC'


  def to_label
    self.nom
  end

end