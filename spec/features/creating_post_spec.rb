require "rails_helper"

RSpec.feature "Creating posts" do
  scenario "A user creates a new post" do
    user = FactoryBot.create(:user)
    login_as(user, :scope => :user)

    visit "/"

    click_link "New post"

    fill_in "post[title]", with: "Sample title"
    fill_in "post[body]", with: "Sample body"

    click_button "Create Post"

    expect(page).to have_content("Post created successfully!")
    #expect(page.current_path).to eq(???) TODO: add post path as parameter
  end
end