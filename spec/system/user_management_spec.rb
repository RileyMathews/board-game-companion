require "rails_helper"

RSpec.describe "User lifecycle" do
  it "can create and login a user" do
    user_email = "test@test.com"
    user_password = "Password1@"
    visit "/users/sign_up"
    fill_in "Email", with: user_email
    fill_in "Password", with: user_password
    fill_in "Password confirmation", with: user_password
    fill_in "Username", with: "username"
    click_button "Sign Up"

    expect(page).to have_text("A message with a confirmation link")

    confirmation_token = User.find_by(email: user_email).confirmation_token
    visit "/users/confirmation?confirmation_token=#{confirmation_token}"

    expect(page).to have_text("successfully confirmed")

    click_on "Login"

    expect(page).to have_text("Log in")

    fill_in "Email", with: user_email
    fill_in "Password", with: user_password
    click_button "Log In"

    expect(page).to have_text("Welcome to board game companion!")
  end
end
