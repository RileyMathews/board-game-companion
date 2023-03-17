require 'rails_helper'

RSpec.describe "games/edit", type: :view do
  let(:game) {
    Game.create!(
      name: "MyString",
      uuid: "",
      slug: "MyString",
      created_by: nil
    )
  }

  before(:each) do
    assign(:game, game)
  end

  it "renders the edit game form" do
    render

    assert_select "form[action=?][method=?]", game_path(game), "post" do

      assert_select "input[name=?]", "game[name]"

      assert_select "input[name=?]", "game[uuid]"

      assert_select "input[name=?]", "game[slug]"

      assert_select "input[name=?]", "game[created_by_id]"
    end
  end
end
