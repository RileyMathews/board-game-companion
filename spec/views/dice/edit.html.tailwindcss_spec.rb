require 'rails_helper'

RSpec.describe "dice/edit", type: :view do
  let(:die) {
    Die.create!(
      name: "MyString",
      game: nil
    )
  }

  before(:each) do
    assign(:die, die)
  end

  it "renders the edit die form" do
    render

    assert_select "form[action=?][method=?]", die_path(die), "post" do

      assert_select "input[name=?]", "die[name]"

      assert_select "input[name=?]", "die[game_id]"
    end
  end
end
