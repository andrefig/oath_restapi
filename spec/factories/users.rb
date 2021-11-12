FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "jsmith #{n}" }
    name { "John Smith" }
    url { "MyString" }
    avatar_url { "example.com/avatar" }
    provider { "github" }
  end
end
