# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  price       :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Product do
  let(:product) { FactoryGirl.create(:product) }
  subject { @product }

  it { should be_valid }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:price) }

  describe "when has no title" do
    before { product.title = nil }
    it { should_not be_valid }
  end

end
