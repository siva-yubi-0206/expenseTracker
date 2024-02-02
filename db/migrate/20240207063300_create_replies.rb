class CreateReplies < ActiveRecord::Migration[7.1]
  def change
    create_table :replies do |t|
      t.text :replies

      t.timestamps
    end
  end
end
