# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# サンプル施設データ

# テスト用ユーザーを作成（すでにいる場合は不要）
user = User.first || User.create!(email: "test@example.com", password: "password", password_confirmation: "password")

rooms_data = [
  { name: "大阪ステイホテル", address: "大阪府大阪市中央区", detail: "大阪中心地の便利なホテルです", price: 10000 },
  { name: "京都和風旅館", address: "京都府京都市東山区", detail: "京都の伝統的な旅館でゆったり滞在", price: 12000 },
  { name: "札幌スカイホテル", address: "札幌市中央区", detail: "札幌駅近くで観光に便利", price: 9000 },
  { name: "大阪ビジネスホテル", address: "大阪府大阪市北区", detail: "ビジネス向けシンプルホテル", price: 8000 },
  { name: "京都モダンホテル", address: "京都府京都市下京区", detail: "モダンな内装のホテル", price: 11000 },
  { name: "札幌ゲストハウス", address: "札幌市北区", detail: "格安で泊まれるゲストハウス", price: 5000 }
]

rooms_data.each do |room_attrs|
  user.rooms.create!(room_attrs)
end

puts "サンプル施設データを作成しました！"
