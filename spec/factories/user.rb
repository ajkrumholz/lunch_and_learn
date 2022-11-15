FactoryBot.define do
  factory :user do
    name { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { "keyboard123" }
    password_confirmation { "keyboard123" }
  end
end