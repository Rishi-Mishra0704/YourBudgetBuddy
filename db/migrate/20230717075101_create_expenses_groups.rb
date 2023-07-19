# db/migrate/20230703153813_create_expenses_groups.rb

class CreateExpensesGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses_groups, id: false do |t|
      t.references :group, null: false, foreign_key: true
      t.references :expense, null: false, foreign_key: true
    end

    add_index :expenses_groups, [:expense_id, :group_id]
    add_index :expenses_groups, [:group_id, :expense_id]
  end
end
