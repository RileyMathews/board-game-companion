FactoryBot.define do
  factory :roll do
    user
    room
    archived { false }
  end
end
