FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      name = "Admin"
      admin true
    end
  end
  
  factory :product do
    sequence(:name)  { |n| "Product #{n}" }
    sequence(:price) { |n| n+1.5 }   
    sequence(:description)  { |n| "Descripcio del producte #{n}" }
  end
end