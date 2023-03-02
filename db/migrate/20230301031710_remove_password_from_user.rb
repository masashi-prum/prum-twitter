class RemovePasswordFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :password, :string
    remove_column :users, :password_confirmation, :string
  end
end
