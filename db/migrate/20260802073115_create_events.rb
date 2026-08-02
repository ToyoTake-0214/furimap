class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.references :user, null: false, foreign_key: true

      t.string :name, null: false
      t.text :description
      t.string :address, null: false
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
