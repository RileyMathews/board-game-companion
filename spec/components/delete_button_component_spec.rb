require "rails_helper"

RSpec.describe DeleteButtonComponent, type: :component do
  it "renders a button with expected attributes" do
    component = described_class.new text: "hello", href: "/path"

    render_inline component

    expect(page).to have_selector 'form[action="/path"]'
    expect(page).to have_selector 'input[name="_method"][value="delete"]', visible: :hidden
  end
end
