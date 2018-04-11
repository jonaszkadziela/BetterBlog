FactoryBot.define do
  factory :user do
    email "test@example.com"
    password "qwerty"
  end

  factory :post do
    title "Sample title"
    body "Sample body"
  end

  factory :comment do
    name "Sample name"
    body "Sample comment"
  end
end