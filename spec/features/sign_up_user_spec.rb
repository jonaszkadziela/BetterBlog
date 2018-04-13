require "rails_helper"

RSpec.feature "A user signs up" do
  let(:user) { FactoryBot.build(:user) }

  scenario "" do
    visit "/"

    click_link "Sign in"
    click_link "Sign up"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password

    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
  end
end