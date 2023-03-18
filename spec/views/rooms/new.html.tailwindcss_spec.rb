require 'rails_helper'

RSpec.describe "rooms/new", type: :view do
  before(:each) do
    assign(:room, Room.new(
      name: "MyString",
      slug: "MyString",
      uuid: "",
      game: nil
    ))
  end

  it "renders new room form" do
    render

    assert_select "form[action=?][method=?]", rooms_path, "post" do

      assert_select "input[name=?]", "room[name]"

      assert_select "input[name=?]", "room[slug]"

      assert_select "input[name=?]", "room[uuid]"

      assert_select "input[name=?]", "room[game_id]"
    end
  end
end
