class RemoveCommentIdFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :comment_id, :integer
  end
end
