require "rails_helper"

RSpec.describe User do
  subject { create :user }

  describe "associations" do
    it { is_expected.to have_many(:games).with_foreign_key(:created_by_id) }
    it { is_expected.to have_many :user_rooms }
    it { is_expected.to have_many :rooms }
    it { is_expected.to have_many :room_resources }
  end
end
