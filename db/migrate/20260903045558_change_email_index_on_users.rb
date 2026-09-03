class ChangeEmailIndexOnUsers < ActiveRecord::Migration[8.1]
  def change
    remove_index :users, :email
    add_index :users, [:email, :role], unique: true
  end
end
