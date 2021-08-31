User.destroy_all
Article.destroy_all
Tag.destroy_all
TagMap.destroy_all

require "csv"

puts "ユーザーデータのインポートを開始します"

user_data_list = []
CSV.foreach("db/csv_data/user_data.csv", headers: true) do |row|
  user_data_list << { name: row["name"], email: row["email"], password: row["password"], profile: row["profile"] }
end

User.create!(user_data_list)
user1, user2, user3, user4, user5, user6 = User.all

puts "ユーザーデータのインポートに成功しました"
