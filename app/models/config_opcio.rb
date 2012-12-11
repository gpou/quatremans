class ConfigOpcio < ActiveRecord::Base
  attr_accessible :nom, :tipus, :preu, :svg, :locale, :translations_attributes

  translates :nom, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations

  has_and_belongs_to_many :config_grups
end