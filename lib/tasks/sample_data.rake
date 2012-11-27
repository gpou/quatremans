namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(name: "Administrador",
                         email: "gemma@ideesenxarxa.com",
                         password: "surdo000",
                         password_confirmation: "surdo000")
    admin.toggle!(:admin)

    15.times do |n|
      name = Faker::Lorem.words(5)
      description  = Faker::Lorem.paragraphs(3)
      price = 10+rand(10)
      Producte.create!(:nom => name,
                      :preu => price,
                      :descripcio => description)
    end
  end
end