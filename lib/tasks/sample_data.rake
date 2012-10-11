namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Root User",
                         email: "gemma@ideesenxarxa.com",
                         password: "surdo000",
                         password_confirmation: "surdo000")
    admin.toggle!(:admin)
  end
end