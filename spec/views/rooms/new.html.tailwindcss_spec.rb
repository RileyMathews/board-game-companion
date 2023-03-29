require 'rails_helper'

RSpec.describe "rooms/new", type: :view do
  before(:each) do
    assign(:room, Room.new(
      game: nil,
      name: "MyString",
      created_by: nil
    ))
  end

  it "renders new room form" do
    render

    assert_select "form[action=?][method=?]", rooms_path, "post" do

      assert_select "input[name=?]", "room[game_id]"

      assert_select "input[name=?]", "room[name]"

      assert_select "input[name=?]", "room[created_by_id]"
    end
  end
end
