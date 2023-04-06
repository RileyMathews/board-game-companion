FactoryBot.define do
  factory :resource do
    game { nil }
    name { "MyString" }
    min { 1 }
    max { 1 }
  end
end
