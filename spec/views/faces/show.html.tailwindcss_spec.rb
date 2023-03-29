require 'rails_helper'

RSpec.describe "faces/show", type: :view do
  before(:each) do
    assign(:face, Face.create!(
      die: nil,
      name: "Name",
      count: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
  end
end
