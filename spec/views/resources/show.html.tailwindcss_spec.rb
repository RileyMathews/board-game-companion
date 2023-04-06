require 'rails_helper'

RSpec.describe "resources/show", type: :view do
  before(:each) do
    assign(:resource, Resource.create!(
      game: nil,
      name: "Name",
      min: 2,
      max: 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
