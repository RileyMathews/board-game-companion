FactoryBot.define do
  factory :face do
    die { die }
    name { SecureRandom.uuid }
    count { 1 }
  end
end
