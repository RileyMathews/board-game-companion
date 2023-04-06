require 'rails_helper'

RSpec.describe "resources/new", type: :view do
  before(:each) do
    assign(:resource, Resource.new(
      game: nil,
      name: "MyString",
      min: 1,
      max: 1
    ))
  end

  it "renders new resource form" do
    render

    assert_select "form[action=?][method=?]", resources_path, "post" do

      assert_select "input[name=?]", "resource[game_id]"

      assert_select "input[name=?]", "resource[name]"

      assert_select "input[name=?]", "resource[min]"

      assert_select "input[name=?]", "resource[max]"
    end
  end
end
