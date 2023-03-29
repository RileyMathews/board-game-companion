require 'rails_helper'

RSpec.describe "dice/new", type: :view do
  before(:each) do
    assign(:die, Die.new(
      name: "MyString",
      game: nil
    ))
  end

  it "renders new die form" do
    render

    assert_select "form[action=?][method=?]", dice_path, "post" do

      assert_select "input[name=?]", "die[name]"

      assert_select "input[name=?]", "die[game_id]"
    end
  end
end
