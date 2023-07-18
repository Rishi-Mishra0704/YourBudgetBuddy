# spec/models/expense_spec.rb
require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:user) { User.create(name: 'Test User') }

  describe "associations" do
    it { should belong_to(:author).class_name('User').with_foreign_key(:author_id) }
    it { should have_and_belong_to_many(:groups).class_name('Group').join_table('expenses_groups') }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:amount) }
    it { should validate_numericality_of(:amount).is_greater_than(0) }
  end

  describe "#added_group" do
    it "returns the number of groups the expense is associated with" do
      expense = Expense.new(name: "Test Expense", amount: 100, author: user)
      group_a = Group.create(name: "Group A", icon: "icon-a")
      group_b = Group.create(name: "Group B", icon: "icon-b")
      expense.groups << [group_a, group_b]

      expect(expense.added_group).to eq(2)
    end

    it "returns 0 if the expense is not associated with any group" do
      expense = Expense.new(name: "Test Expense", amount: 100, author: user)

      expect(expense.added_group).to eq(0)
    end
  end

  describe "#add_unique_group" do
    it "adds a group to the expense if it's not already associated" do
      expense = Expense.new(name: "Test Expense", amount: 100, author: user)
      group = Group.create(name: "Group A", icon: "icon-a")

      expense.add_unique_group(group)
      expect(expense.groups).to include(group)
    end
  end
end
