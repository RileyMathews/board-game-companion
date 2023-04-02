FactoryBot.define do
  factory :die do
    name { SecureRandom.uuid }
    game { game }
  end
end
