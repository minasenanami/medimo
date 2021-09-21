FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    content { Faker::Lorem.sentence }
    user

    trait :draft do
      status { :draft }
    end

    trait :published do
      status { :published }
    end

    trait :closed do
      status { :closed }
    end
  end
end
