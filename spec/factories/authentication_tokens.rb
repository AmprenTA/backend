FactoryBot.define do
  factory :authentication_token do
    token { "MyString" }
    user { nil }
    expires_at { "2022-11-04 10:02:04" }
  end
end
