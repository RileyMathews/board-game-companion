require 'rails_helper'

RSpec.describe "faces/index", type: :view do
  before(:each) do
    assign(:faces, [
      Face.create!(
        die: nil,
        name: "Name",
        count: 2
      ),
      Face.create!(
        die: nil,
        name: "Name",
        count: 2
      )
    ])
  end

  it "renders a list of faces" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
  end
end
