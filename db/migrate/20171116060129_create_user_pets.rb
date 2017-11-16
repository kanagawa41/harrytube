class CreateUserPets < ActiveRecord::Migration[5.1]
  def change
    create_table :user_pets do |t|
      t.references :user, foreign_key: true
      t.boolean :has_icon
      t.string :pet_name, null: false
      t.date :pet_birthday
      t.string :pet_type
      t.integer :pet_sex
      t.string :one_phrase

      t.timestamps
    end
  end
end
