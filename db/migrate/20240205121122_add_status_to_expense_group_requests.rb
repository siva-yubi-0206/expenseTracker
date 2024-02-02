class AddStatusToExpenseGroupRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :expense_group_requests, :status, :string
  end
end
