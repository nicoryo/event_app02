class AddHashbodyToUsers < ActiveRecord::Migration[6.0]
  def up
    add_column :users, :hashbody, :text
    change_column :users, :hashbody, :text,  null: false, default: ""
  end

  def down
    remove_column :users, :hashbody, :text

  end
end
