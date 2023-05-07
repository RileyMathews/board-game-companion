FactoryBot.define do
  factory :room_resource do
    user
    room
    resource
    amount { 0 }
  end
end
