class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, index: true, foreign_key: true
      t.references :entry, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:entry_id, :created_at]
  end
end
