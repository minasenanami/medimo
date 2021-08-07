User.destroy_all
Article.destroy_all

name = "test_user"
email = "test@example.com"
password = "password"

# テストユーザーが存在しないときだけ作成
User.find_or_create_by!(email: email) do |user|
  user.name = name
  user.password = password
end

user = User.first
user.articles.create!(title: "test投稿", content: "testユーザの作成記事", status: 0)
