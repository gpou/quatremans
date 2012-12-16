class Producte < ActiveRecord::Base
  attr_accessible :slug, :nom, :descripcio, :preu, :locale, :coleccio_id, :translations_attributes, :fotos_attributes, :disponible, :actiu, :tipus, :dificultat, :coordenades_coleccio, :dibuix, :svg, :svg_davant, :svg_darrera, :position, :coleccio_path, :coleccio_mascara_path, :configparametres_attributes

  translates :nom, :slug, :descripcio, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations

  belongs_to :coleccio
  validates_presence_of :coleccio

  acts_as_list :scope => :coleccio
  default_scope :order => 'position ASC'

  has_many :fotos, :dependent => :destroy
  accepts_nested_attributes_for :fotos, :allow_destroy => true

  has_many :configparametres, :dependent => :destroy
  accepts_nested_attributes_for :configparametres, :allow_destroy => true

  has_attached_file :dibuix, 
    :styles => { :thumb => "117", :medium => "284x400" },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "dibuixos/:id/:style_:filename",
    :url => ":s3_domain_url"

  extend FriendlyId
  friendly_id :nom, :use => [:globalize, :scoped], :scope => :coleccio
  #before_validation :translate_slugs

  scope :disponible, :conditions => ["disponible = ?",true]
  scope :actiu, :conditions => ["actiu = ?",true]
  
  scope :model, :conditions => ["tipus = ?","model"]
  scope :nina, :conditions => ["tipus = ?","nina"]
  scope :model_o_nina, :conditions => ["tipus = ? OR tipus = ?","model", "nina"]
  scope :model_nina, :conditions => ["tipus = ?","model_nina"]

  class Translation
    attr_accessible :locale, :slug, :nom, :descripcio
    validates :nom, presence: true
  end

  def to_label
    self.nom
  end

  def name
    self.nom
  end

  def translate_slugs
    I18n.with_locale(:es) { set_friendly_id(nom, :es) }
    I18n.with_locale(:en) { set_friendly_id(nom, :en) }
    I18n.with_locale(:ca) {  }
  end

end
