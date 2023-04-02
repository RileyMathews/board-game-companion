FactoryBot.define do
  factory :user, aliases: [:created_by] do
    username { SecureRandom.uuid }
    email { "#{username}@test.com" }
    password { "Password1@" }
    confirmed_at { 10.days.ago }
  end
end
