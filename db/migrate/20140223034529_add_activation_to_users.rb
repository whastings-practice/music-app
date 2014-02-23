class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean, null: false, default: false
    add_column :users, :activation_token, :string
    add_index :users, :activation_token, unique: true
  end
end
