FactoryGirl.define do
  factory :product do
    sequence(:product)  { |n| "Product #{n}" }
    sequence(:price) { |n| n+1.5 }   
    sequence(:product)  { |n| "Descripcio del producte #{n}" }
  end
end