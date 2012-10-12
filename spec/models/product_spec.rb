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

require 'spec_helper'

describe Product do
  before do 
    @product = Product.new(name: "Producte", price:10)
  end

  subject { @product }

  it { should be_valid }
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }

  describe "when name is not present" do
    before { @product.name = " " }
    it { should_not be_valid }
  end

  describe "when price is not present" do
    before { @product.price = nil }
    it { should_not be_valid }
  end

end
