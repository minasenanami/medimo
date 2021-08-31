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

def import_article(path, user)
  list = []
  CSV.foreach("db/csv_data/article_data/#{path}", headers: true) do |row|
    list << { title: row["title"], content: row["content"], status: row["status"].to_i, user: user }
  end
  Article.create!(list)
end

puts "記事データのインポートを開始します"
import_article("user1_article_data.csv", user1)
import_article("user2_article_data.csv", user2)
import_article("user3_article_data.csv", user3)
import_article("user4_article_data.csv", user4)
import_article("user5_article_data.csv", user5)

puts "記事データのインポートが完了しました"
