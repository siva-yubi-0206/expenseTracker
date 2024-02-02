class RemoveExpenseGroupIdFromExpenseRequests < ActiveRecord::Migration[7.1]
  def change
    remove_column :expense_requests, :expense_group_id, :integer
  end
end
