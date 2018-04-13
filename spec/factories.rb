FactoryBot.define do
  factory :user do |u|
    u.sequence(:email) { |u| "test#{u}@test.com" }
    password "qwerty"
  end

  factory :post do |p|
    p.sequence(:title) { |p| "Post title #{p}" }
    p.sequence(:body) { |p| "Post body #{p}" }
    user
  end

  factory :comment do
    name "Comment name"
    body "Comment body"
  end
end