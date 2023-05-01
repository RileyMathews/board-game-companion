require "rails_helper"

RSpec.describe Room do
  subject { create :room }

  describe "associations" do
    it { is_expected.to belong_to :game }
    it { is_expected.to belong_to(:created_by).class_name("User") }
    it { is_expected.to have_many :user_rooms }
    it { is_expected.to have_many :users }
    it { is_expected.to have_many :room_resources }
    it { is_expected.to have_many :resources }
    it { is_expected.to have_many :rolls }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:created_by_id) }
  end

  describe "after_create callback" do
    it "adds the creating user to the list of players" do
      room = create :room

      expect(room.users).to include room.created_by
    end
  end
end
