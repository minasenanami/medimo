require "csv"

User.destroy_all
Article.destroy_all
Tag.destroy_all
TagMap.destroy_all

guest_user_profile = <<~EOS
機能制限中につき以下は行えません
  ・プロフィール変更
  ・登録内容の変更
  ・ユーザーの削除
EOS

NAME = "ゲストユーザー"
EMAIL = "guest@example.com"
PASSWORD = SecureRandom.urlsafe_base64
PROFILE = guest_user_profile

puts "ゲストユーザーを作成します"
User.create!(name: NAME, email: EMAIL, password: PASSWORD, profile: PROFILE )
puts "ゲストユーザーが作成されました"


puts "ユーザーデータのインポートを開始します"

user_data_list = []
CSV.foreach("db/csv_data/user_data.csv", headers: true) do |row|
  user_data_list << { name: row["name"], email: row["email"], password: row["password"], profile: row["profile"] }
end

User.create!(user_data_list)
user1, user2, user3, user4, user5, user6 = User.all

puts "ユーザーデータのインポートに成功しました"
