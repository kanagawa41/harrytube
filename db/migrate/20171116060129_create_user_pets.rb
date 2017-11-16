class CreateUserPets < ActiveRecord::Migration[5.1]
  def change
    create_table :user_pets do |t|
      t.references :user, foreign_key: true
      t.boolean :has_icon
      t.string :pet_name
      t.string :pet_type
      t.string :pet_sex

      t.timestamps
    end
  end
end
