require "rails_helper"

RSpec.shared_examples "sign in user" do |user_login|
  scenario "with valid credentials" do
    visit "/"
    click_link "Sign in"
    fill_in "Email or username", with: user.email if (user_login == :email)
    fill_in "Email or username", with: user.username if (user_login == :username)
    fill_in "Password", with: user.password
    click_button "Log in"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content(user.username)
    expect(page).to have_link("New post")
    expect(page).not_to have_link("Sign in")
  end
end