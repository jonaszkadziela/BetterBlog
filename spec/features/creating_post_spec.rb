require "rails_helper"

RSpec.feature "Creating posts" do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end

  scenario "A user creates a new post" do
    visit "/"

    click_link "New post"

    fill_in "Title", with: "Sample title"
    fill_in "Body", with: "Sample body"

    click_button "Create Post"

    expect(page).to have_content("Post created successfully!")
  end

  scenario "A user fails to create a new post" do
    visit "/"

    click_link "New post"

    fill_in "Title", with: ""
    fill_in "Body", with: ""

    click_button "Create Post"

    expect(page).to have_content("prevented this post from being saved:")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end