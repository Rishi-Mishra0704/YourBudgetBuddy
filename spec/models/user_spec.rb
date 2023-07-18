# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:groups).class_name('Group').with_foreign_key(:user_id).dependent(:destroy) }
    it { should have_many(:expenses).class_name('Expense').with_foreign_key(:author_id).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2).is_at_most(250) }
  end
end
