FactoryBot.define do
  factory :article do
    title { "MyString" }
    content { "MyText" }
    status { 1 }
    user { nil }
  end
end
