FactoryBot.define do
  factory :room_resource do
    user
    room
    resource
    amount { 1 }
  end
end
