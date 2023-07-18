# spec/factories/expense.rb

FactoryBot.define do
    factory :expense do
      name { Faker::Lorem.word }
      amount { Faker::Number.decimal(l_digits: 2) }
      association :author, factory: :user
      groups { [] }
  
      # Define additional attributes or custom methods as needed
    end
  end
  