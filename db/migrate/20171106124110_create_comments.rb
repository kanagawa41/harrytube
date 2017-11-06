class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.references :user, foreign_key: true, null: false, index: false
      t.references :post, foreign_key: true, null: false, index: false
      t.string :comment, null: false

      t.timestamps
    end
  end
end
