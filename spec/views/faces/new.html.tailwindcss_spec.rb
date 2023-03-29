require 'rails_helper'

RSpec.describe "faces/new", type: :view do
  before(:each) do
    assign(:face, Face.new(
      die: nil,
      name: "MyString",
      count: 1
    ))
  end

  it "renders new face form" do
    render

    assert_select "form[action=?][method=?]", faces_path, "post" do

      assert_select "input[name=?]", "face[die_id]"

      assert_select "input[name=?]", "face[name]"

      assert_select "input[name=?]", "face[count]"
    end
  end
end
