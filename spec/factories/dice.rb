FactoryBot.define do
  factory :die do
    name { SecureRandom.uuid }
    game
  end
end
