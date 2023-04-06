require 'rails_helper'

RSpec.describe "resources/edit", type: :view do
  let(:resource) {
    Resource.create!(
      game: nil,
      name: "MyString",
      min: 1,
      max: 1
    )
  }

  before(:each) do
    assign(:resource, resource)
  end

  it "renders the edit resource form" do
    render

    assert_select "form[action=?][method=?]", resource_path(resource), "post" do

      assert_select "input[name=?]", "resource[game_id]"

      assert_select "input[name=?]", "resource[name]"

      assert_select "input[name=?]", "resource[min]"

      assert_select "input[name=?]", "resource[max]"
    end
  end
end
