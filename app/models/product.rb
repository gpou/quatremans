# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name       :string(255)
#  description :string(255)
#  price       :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
  attr_accessible :description, :price, :name

  validates :name, presence: true
  validates :price, presence: true
end
