class AddBirthaddressToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birthaddress, :string
  end
end
