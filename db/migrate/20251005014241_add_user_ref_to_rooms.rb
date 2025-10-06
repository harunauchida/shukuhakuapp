class AddUserRefToRooms < ActiveRecord::Migration[6.1]
  def change
    # まず null を許可して追加
    add_reference :rooms, :user, null: true, foreign_key: true

    # 既存レコードにデフォルトのユーザーIDを入れる
    Room.reset_column_information
    Room.all.each do |room|
      room.update!(user_id: 1) # ユーザーID 1 に紐付ける例
  end

    # NOT NULL 制約を追加
    change_column_null :rooms, :user_id, false
  end
end