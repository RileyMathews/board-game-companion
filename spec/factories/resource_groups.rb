FactoryBot.define do
  factory :resource_group do
    name { SecureRandom.uuid }
    game
  end
end
