FactoryBot.define do
  factory :room_resource do
    user
    room
    resource
    ammount { 1 }
  end
end
