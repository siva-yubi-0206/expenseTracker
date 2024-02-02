class AddReplyToComments < ActiveRecord::Migration[7.1]
  def change
    add_column :comments, :reply, :text
  end
end
