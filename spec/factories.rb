FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "test#{n}" }
    sequence(:email) { |n| "test#{n}@test.com" }
    password "qwerty"
  end

  factory :post do
    sequence(:title) { |n| "Post title #{n}" }
    sequence(:body) { |n| "Post body #{n}" }
    user
  end

  factory :comment do
    sequence(:body) { |n| "Comment body #{n}" }
    user
    post
  end
end