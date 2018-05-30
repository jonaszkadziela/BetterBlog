require "rails_helper"

RSpec.feature "Editing a post" do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user1) }

  describe "a signed in user" do
    scenario "edits his post" do
      login_as(user1, scope: :user)
      visit "/"
      click_link post.title
      click_link "Edit"
      fill_in "Title", with: "Updated title"
      fill_in "Body", with: "Updated body"
      click_button "Update Post"

      expect(page).to have_content "Post updated successfully!"
      expect(page).to have_content "Updated title"
      expect(page).to have_content "Updated body"
      expect(current_path).to eq(post_path(post))
    end

    scenario "can't edit someone else's post" do
      login_as(user2, scope: :user)
      visit "/"
      click_link post.title

      expect(page).not_to have_link("Edit", href: edit_post_path(post))
      expect(current_path).to eq(post_path(post))
    end
  end

  describe "an anonymous user" do
    scenario "can't edit someone's post" do
      visit "/"
      click_link post.title

      expect(page).not_to have_link("Edit", href: edit_post_path(post))
      expect(current_path).to eq(post_path(post))
    end
  end
end
