class AddNameToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :name, :string
    change_column :users, :name, :string, null: false, default: ""
  end


  def down
    remove_column :users, :name, :string
  end
end
