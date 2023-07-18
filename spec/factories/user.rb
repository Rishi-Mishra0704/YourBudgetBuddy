# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      sequence(:name) { |n| "User #{n}" }
      email { Faker::Internet.email }
      password { 'password123' } # Adjust the default password as needed
      password_confirmation { 'password123' }
    end
  end
  