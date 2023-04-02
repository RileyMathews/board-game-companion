FactoryBot.define do
  factory :room do
    game
    name { SecureRandom.uuid }
    created_by
  end
end
