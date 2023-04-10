FactoryBot.define do
  factory :roll_result do
    face
    roll
    archived { false }
  end
end
