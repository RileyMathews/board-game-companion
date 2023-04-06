FactoryBot.define do
  factory :resource do
    game
    name { SecureRandom.uuid }
    min { 1 }
    max { 1 }
  end
end
