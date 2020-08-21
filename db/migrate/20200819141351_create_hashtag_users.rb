class CreateHashtagUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :hashtag_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
