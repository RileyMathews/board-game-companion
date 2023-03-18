require 'rails_helper'

RSpec.describe "rooms/show", type: :view do
  before(:each) do
    assign(:room, Room.create!(
      name: "Name",
      slug: "Slug",
      uuid: "",
      game: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
