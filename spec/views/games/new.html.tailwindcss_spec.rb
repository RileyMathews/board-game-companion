require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, Game.new(
      name: "MyString",
      uuid: "",
      slug: "MyString",
      created_by: nil
    ))
  end

  it "renders new game form" do
    render

    assert_select "form[action=?][method=?]", games_path, "post" do

      assert_select "input[name=?]", "game[name]"

      assert_select "input[name=?]", "game[uuid]"

      assert_select "input[name=?]", "game[slug]"

      assert_select "input[name=?]", "game[created_by_id]"
    end
  end
end
