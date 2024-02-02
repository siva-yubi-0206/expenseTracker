class RemoveReplyFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :reply, :text
  end
end
