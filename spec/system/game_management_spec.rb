require "rails_helper"

RSpec.describe "game management", type: :system do
  it "log a user in" do
    visit "/users/sign_in"

    expect(page).to have_text("Log in")

    fill_in "Email", with: "test@test.com"
    fill_in "Password", with: "Password1@"
    click_button "Log In"

    expect(page).to have_text("You're games")
  end
end
