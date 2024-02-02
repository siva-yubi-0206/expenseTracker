class AddAdminStatusToEmployee < ActiveRecord::Migration[7.1]
  def change
    add_column :employees, :admin_status, :boolean
  end
end
