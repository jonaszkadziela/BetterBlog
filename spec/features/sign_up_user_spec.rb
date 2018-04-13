require "rails_helper"

RSpec.feature "A user signs up" do
  let(:user) { FactoryBot.build(:user) }

  before(:each) do
    visit "/"
    click_link "Sign in"
    click_link "Sign up"
  end

  scenario "with valid credentials" do
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password
    click_button "Sign up"

    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario "with invalid credentials" do
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_button "Sign up"
    
    expect(page).to have_content("prohibited this user from being saved")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
end