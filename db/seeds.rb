require "csv"

User.destroy_all
Article.destroy_all
Tag.destroy_all
TagMap.destroy_all


#------------------------ ゲストユーザー作成 --------------------------------------

guest_user_profile = <<~EOS
機能制限中につき以下は行えません
・プロフィール変更
・登録内容の変更
・ユーザーの削除
EOS

NAME = "ゲストユーザー".freeze
EMAIL = "guest@example.com".freeze
PASSWORD = SecureRandom.urlsafe_base64
PROFILE = guest_user_profile

puts "ゲストユーザーを作成します"
User.create!(name: NAME, email: EMAIL, password: PASSWORD, profile: PROFILE)
puts "ゲストユーザーが作成されました"

#------------------------ ゲストユーザー作成 --------------------------------------



#------------------------ ユーザーデータ作成 --------------------------------------
puts "ユーザーデータのインポートを開始します"

user_data_list = []
CSV.foreach("db/csv_data/user_data.csv", headers: true) do |row|
  user_data_list << { name: row["name"], email: row["email"], password: row["password"], profile: row["profile"] }
end

User.create!(user_data_list)

user1, user2, user3, user4, user5, user6 = User.all

puts "ユーザーデータのインポートに成功しました"

#------------------------ ユーザーデータ作成 --------------------------------------


#------------------------ 記事データ作成 --------------------------------------

def import_article(path, user)
  list = []
  CSV.foreach("db/csv_data/article_data/#{path}", headers: true) do |row|
    list << { title: row["title"], content: row["content"], status: row["status"].to_i, user: user }
  end
  Article.create!(list)
end

puts "記事データのインポートを開始します"
import_article("user1_article_data.csv", user1)
import_article("user6_article_data.csv", user6)
import_article("user3_article_data.csv", user3)

puts "記事データのインポートが完了しました"

#------------------------ 記事データ作成 --------------------------------------



#------------------------ 保存データの作成 --------------------------------------
KEEPS_COUNT = 15
puts "保存データの作成を開始"
target = Article.published.pluck(:id).sample(KEEPS_COUNT)
target.each do |article|
  user1.keeps.create!(article_id: article)
end
puts "保存データの作成に成功しました"

#------------------------ 保存データの作成 --------------------------------------


#------------------------ いいねデータの作成 --------------------------------------
LIKES_COUNT = 5
puts "いいねデータの作成を開始"

def create_likes(user)
  like_target = Article.published.pluck(:id).sample(LIKES_COUNT)
  like_target.each do |article|
    user.likes.create!(article_id: article)
  end
end

create_likes(user1)
create_likes(user2)
puts "いいねデータの作成に成功しました"

#------------------------ いいねデータの作成 --------------------------------------
