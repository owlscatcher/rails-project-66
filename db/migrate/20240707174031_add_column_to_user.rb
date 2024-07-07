class AddColumnToUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :name
    add_column :users, :nickname, :string
    add_column :users, :token, :string
  end
end
