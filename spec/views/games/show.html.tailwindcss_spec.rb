require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    assign(:game, Game.create!(
      name: "Name",
      uuid: "",
      slug: "Slug",
      created_by: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(//)
  end
end
