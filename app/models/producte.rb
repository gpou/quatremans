class Producte < ActiveRecord::Base
  attr_accessible :slug, :nom, :descripcio, :preu, :locale, :coleccio_id, :translations_attributes, :fotos_attributes

  translates :nom, :slug, :descripcio, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations

  belongs_to :coleccio
  validates_presence_of :coleccio

  has_many :fotos, :dependent => :destroy
  accepts_nested_attributes_for :fotos, :allow_destroy => true

  extend FriendlyId
  friendly_id :nom, :use => [:globalize, :scoped], :scope => :coleccio
  #before_validation :translate_slugs

  class Translation
    attr_accessible :locale, :slug, :nom, :descripcio
    validates :nom, presence: true
  end

  def to_label
    self.nom
  end

  def translate_slugs
    I18n.with_locale(:es) { set_friendly_id(nom, :es) }
    I18n.with_locale(:en) { set_friendly_id(nom, :en) }
  end

end
