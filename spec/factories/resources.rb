FactoryBot.define do
  factory :resource do
    game
    name { SecureRandom.uuid }
    min { 1 }
    max { 1 }
    # TODO: see how to make resource group belong to the same game as resource
    resource_group
  end
end
