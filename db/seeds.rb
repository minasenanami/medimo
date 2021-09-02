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
create_likes(user3)
create_likes(user4)
create_likes(user5)
create_likes(user6)

puts "いいねデータの作成に成功しました"

#------------------------ いいねデータの作成 --------------------------------------






#------------------------ タグデータ作成 --------------------------------------

puts "タグデータを作成します"

create_tag_list = []
tag_list = %w[ ICU 救急 １‐２年目向け 意識レベル確認 JCS ジャパンコーマスケール
  意識レベルの確認 GCS グラスゴーコーマスケール 輸血製剤 輸血の確認 輸血の量
  頭蓋内圧亢進症状 クッシング徴候 脳浮腫 カテーテル検査 アンギオ 血管造影法
  申し送り ６R 輸液ポンプ 精神科 国家試験 過去問 仕事メモ 作業メモ ]


  tag_list.each do |tag|
    create_tag_list << { tag_name: tag }
  end
  Tag.create!(create_tag_list)

  puts "タグデータの作成に成功しました"

  puts "記事にランダムでタグ付けを開始します"
  tag_maps = []
  30.times do
    tag = Tag.pluck(:id).sample
    article = Article.published.pluck(:id).sample
    tag_maps << {article_id: article, tag_id: tag}
  end
  TagMap.create!(tag_maps)
  puts "タグ付けが完了しました"

#------------------------ タグデータ作成 --------------------------------------

puts "初期データの投入が完了しました"
