FactoryBot.define do
  factory :game do
    name { SecureRandom.uuid }
    created_by
  end
end
