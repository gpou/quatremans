class Coleccio < ActiveRecord::Base
  attr_accessible :slug, :nom, :descripcio, :locale, :translations_attributes

  translates :nom, :slug, :descripcio, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations

  has_many :productes, :dependent => :destroy

  extend FriendlyId
  friendly_id :nom, :use => :globalize  
  #before_validation :translate_slugs

  class Translation
    attr_accessible :locale, :slug, :nom, :descripcio
    validates :nom, presence: true
  end

  def to_label
    self.nom
  end

  def translate_slugs
    if !self.new_record?
      I18n.with_locale(:es) { set_friendly_id(nom, :es) }
      I18n.with_locale(:en) { set_friendly_id(nom, :en) }
      I18n.with_locale(:ca) {  }
    end
  end
end
