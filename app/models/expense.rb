class Expense < ApplicationRecord
  # Association
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_and_belongs_to_many :groups, join_table: 'expenses_groups'

  # Validation
  validates :name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }

  # Methods
  def added_group
    groups.length || 0
  end

  def add_unique_group(expense)
    groups << expense unless groups.include?(expense)
  end
end
