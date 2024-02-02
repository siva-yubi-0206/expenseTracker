class AddEmployeeToExpenseGroupRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :expense_group_requests, :employee, null: false, foreign_key: true
  end
end
