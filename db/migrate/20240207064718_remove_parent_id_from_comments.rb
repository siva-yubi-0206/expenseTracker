class RemoveParentIdFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :parent_id, :integer
  end
end
