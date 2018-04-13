require "rails_helper"

RSpec.feature "A user signs out" do
  let(:user) { FactoryBot.create(:user) }

  before do
    login_as(user, :scope => :user)
  end

  scenario do
    visit "/"
    click_link "Sign out"

    expect(page).to have_content("Signed out successfully.")
    expect(page).not_to have_content("Sign out")
  end
end