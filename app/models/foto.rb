class Foto < ActiveRecord::Base
  attr_accessible :position, :nom, :file, :producte_id, :translations_attributes

  translates :nom, :fallbacks_for_empty_translations => true
  accepts_nested_attributes_for :translations

  belongs_to :producte
  validates_presence_of :producte

  acts_as_list :scope => :producte
  default_scope order('position asc')

  Paperclip.interpolates :producte_id  do |attachment, style|
    attachment.instance.producte_id
  end

  has_attached_file :file, 
    :styles => { :thumb => "117", :medium => "350", :wide => "827" },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => "fotos/:producte_id/:id_:style_:filename",
    :url => ":s3_domain_url"

  class Translation
    attr_accessible :nom, :locale
  end

  def to_label
    self.nom
  end

end
