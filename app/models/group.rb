class Group < ApplicationRecord
  # Associations

  belongs_to :user, class_name: 'User', foreign_key: :user_id
  has_and_belongs_to_many :expenses, join_table: 'expenses_groups'

  # validations

  validates :name, presence: true
  validates :icon, presence: true

  # methods

  def add_unique_expense(expense)
    expenses << expense unless expenses.exists?(expense.id)
  end

  def group_expense
    total = 0
    expenses.each do |expense|
      total += expense.amount
    end
    total
  end
end
