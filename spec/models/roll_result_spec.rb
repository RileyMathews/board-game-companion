require "rails_helper"

RSpec.describe RollResult do
  describe "associations" do
    it { is_expected.to belong_to :face }
    it { is_expected.to belong_to :roll }
  end
end
