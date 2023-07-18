require 'rails_helper'

RSpec.describe Group, type: :model do
  # Test associations
  describe "associations" do
    it "belongs to user" do
      expect(Group.reflect_on_association(:user).macro).to eq(:belongs_to)
    end

    it "has and belongs to many expenses" do
      expect(Group.reflect_on_association(:expenses).macro).to eq(:has_and_belongs_to_many)
    end
  end

  # Test validations
  describe "validations" do
    it "requires a name" do
      group = Group.new(icon: "test-icon")
      expect(group.valid?).to be_falsey
      expect(group.errors[:name]).to include("can't be blank")
    end

    it "requires an icon" do
      group = Group.new(name: "Test Group")
      expect(group.valid?).to be_falsey
      expect(group.errors[:icon]).to include("can't be blank")
    end
  end

  # Test methods
  describe "methods" do
    let(:group) { Group.create(name: "Test Group", icon: "test-icon") }
    let(:expense1) { Expense.create(amount: 100) }
    let(:expense2) { Expense.create(amount: 200) }

    describe "#group_expense" do
      it "returns the total expense of the group" do
        group.expenses << [expense1, expense2]
        expect(group.group_expense).to eq(300)
      end

      it "returns 0 if the group has no expenses" do
        expect(group.group_expense).to eq(0)
      end
    end
  end
end
