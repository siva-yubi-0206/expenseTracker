class CreateExpenseRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :expense_requests do |t|
      t.integer :invoice_number
      t.datetime :date
      t.text :description
      t.integer :amount
      t.string :attachment
      t.string :status

      t.timestamps
    end
  end
end
