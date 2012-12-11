class ConfigZona < ActiveRecord::Base
  attr_accessible :config_parametre_id, :svg

  belongs_to :config_parametre
  validates_presence_of :config_parametre
end