class AddDeviseColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      ## Database authenticatable
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at
    end

    # インデックスを追加
    add_index :users, :reset_password_token, unique: true
  end
end
