FactoryBot.define do
  factory :room do
    game
    name { SecureRandom.uuid }
    join_code { SecureRandom.uuid }
    created_by
  end
end
