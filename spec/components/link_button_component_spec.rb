require "rails_helper"

RSpec.describe LinkButtonComponent, type: :component do
  it "renders a link" do
    component = described_class.new text: "hello", href: "/path"

    render_inline component

    expect(page).to have_link "hello", href: "/path"
  end
end
