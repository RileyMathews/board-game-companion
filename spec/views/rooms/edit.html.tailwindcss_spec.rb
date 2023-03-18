require 'rails_helper'

RSpec.describe "rooms/edit", type: :view do
  let(:room) {
    Room.create!(
      name: "MyString",
      slug: "MyString",
      uuid: "",
      game: nil
    )
  }

  before(:each) do
    assign(:room, room)
  end

  it "renders the edit room form" do
    render

    assert_select "form[action=?][method=?]", room_path(room), "post" do

      assert_select "input[name=?]", "room[name]"

      assert_select "input[name=?]", "room[slug]"

      assert_select "input[name=?]", "room[uuid]"

      assert_select "input[name=?]", "room[game_id]"
    end
  end
end
