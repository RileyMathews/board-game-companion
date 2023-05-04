module LoginHelper
  def login_user(user = nil)
    user ||= FactoryBot.create :user
    visit "/users/sign_in"
    fill_in "Email", with: user.email
    fill_in "Password", with: "Password1@"
    click_button "Log In"
    expect(page).to have_text("Signed in successfully.")
    user
  end
end
