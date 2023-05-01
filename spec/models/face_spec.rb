require "rails_helper"

RSpec.describe Face do
  subject { create :face }

  describe "associations" do
    it { is_expected.to belong_to :die }
    it { is_expected.to have_many :roll_results }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:die_id) }
  end
end
