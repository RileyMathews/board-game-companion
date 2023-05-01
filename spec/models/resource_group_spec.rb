require "rails_helper"

RSpec.describe ResourceGroup do
  subject { create :resource_group }

  describe "associations" do
    it { is_expected.to belong_to :game }
    it { is_expected.to have_many :resources }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:game_id) }
  end
end
