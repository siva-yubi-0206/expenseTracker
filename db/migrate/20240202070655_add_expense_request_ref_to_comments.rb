class AddExpenseRequestRefToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :expense_request, null: false, foreign_key: true
  end
end
