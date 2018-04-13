require "rails_helper"

RSpec.feature "Editing a post" do
  before do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
    @post = FactoryBot.create(:post)
  end

  scenario "A user updates a post" do
    visit "/"

    click_link @post.title
    click_link "Edit"

    fill_in "Title", with: "Updated title"
    fill_in "Body", with: "Updated body"

    click_button "Update Post"

    expect(page).to have_content "Post updated successfully!"
    expect(page).to have_content "Updated title"
    expect(page).to have_content "Updated body"
    expect(current_path).to eq(post_path(@post))
  end

  scenario "A user fails to update a post" do
    visit "/"

    click_link @post.title
    click_link "Edit"

    fill_in "Title", with: ""
    fill_in "Body", with: "Updated body"

    click_button "Update Post"

    expect(page).to have_content("prevented this post from being saved:")
    expect(page).to have_content("Title can't be blank")
    expect(current_path).to eq(post_path(@post))
  end
end