require 'rails_helper'

RSpec.describe "dice/show", type: :view do
  before(:each) do
    assign(:die, Die.create!(
      name: "Name",
      game: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
  end
end
