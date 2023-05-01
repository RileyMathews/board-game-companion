require "rails_helper"

RSpec.describe Game do
  subject { create :game }

  describe "associations" do
    it { is_expected.to belong_to(:created_by).class_name("User") }
    it { is_expected.to have_many :dice }
    it { is_expected.to have_many :resources }
    it { is_expected.to have_many :rooms }
    it { is_expected.to have_many :resource_groups }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
  end
end
