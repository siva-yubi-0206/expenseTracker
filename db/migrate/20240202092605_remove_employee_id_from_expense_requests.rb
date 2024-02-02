class RemoveEmployeeIdFromExpenseRequests < ActiveRecord::Migration[7.1]
  def change
    remove_column :expense_requests, :employee_id, :integer
  end
end
