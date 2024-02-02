class AddExpenseGroupRequestRefToExpenseRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :expense_requests, :expense_group_request, null: false, foreign_key: true
  end
end
