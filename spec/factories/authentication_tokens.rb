# frozen_string_literal: true

FactoryBot.define do
  factory :authentication_token do
    token { Faker::Crypto.sha256 }
    user
    expires_at { 10.hours.from_now }
  end
end
