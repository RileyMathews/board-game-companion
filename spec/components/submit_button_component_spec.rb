require "rails_helper"

RSpec.describe SubmitButtonComponent, type: :component do
  it "renders a submit button" do
    component = described_class.new text: "Hello"

    render_inline component

    expect(page).to have_button "Hello", type: "submit"
  end
end
