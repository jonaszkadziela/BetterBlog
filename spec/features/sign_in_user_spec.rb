require "rails_helper"

RSpec.feature "A user signs in" do
  let(:user) { FactoryBot.create(:user) }

  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).not_to have_link("Sign in")
  end
end