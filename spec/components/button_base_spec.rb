require_relative "../../app/components/button_base"

class TestHarness
  include ::ButtonBase

  def initialize(variant)
    @variant = variant
  end
end

RSpec.describe ButtonBase do
  describe "#full_class_list" do
    it "returns the correct class list for default variant" do
      expect(TestHarness.new(:default).full_class_list).to eq "text-sm focus:ring-4 font-medium rounded-lg px-5 py-2.5 mr-2 mb-2 focus:outline-none text-white bg-blue-700 hover:bg-blue-800 focus:ring-blue-300 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800" # rubocop:disable Layout/LineLength
    end

    it "returns the correct class list for light variant" do
      expect(TestHarness.new(:light).full_class_list).to eq "text-sm focus:ring-4 font-medium rounded-lg px-5 py-2.5 mr-2 mb-2 focus:outline-none text-gray-900 bg-white border border-gray-300 focus:outline-none hover:bg-gray-100 focus:ring-gray-200 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700" # rubocop:disable Layout/LineLength
    end
  end
end
