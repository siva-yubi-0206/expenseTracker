class CreateExpenseGroupRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_group_requests do |t|
      t.string :title
      t.integer :applied_amount
      t.integer :approved_amount

      t.timestamps
    end
  end
end
