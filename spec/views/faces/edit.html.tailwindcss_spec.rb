require 'rails_helper'

RSpec.describe "faces/edit", type: :view do
  let(:face) {
    Face.create!(
      die: nil,
      name: "MyString",
      count: 1
    )
  }

  before(:each) do
    assign(:face, face)
  end

  it "renders the edit face form" do
    render

    assert_select "form[action=?][method=?]", face_path(face), "post" do

      assert_select "input[name=?]", "face[die_id]"

      assert_select "input[name=?]", "face[name]"

      assert_select "input[name=?]", "face[count]"
    end
  end
end
