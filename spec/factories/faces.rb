FactoryBot.define do
  factory :face do
    die
    name { SecureRandom.uuid }
    count { 1 }
  end
end
