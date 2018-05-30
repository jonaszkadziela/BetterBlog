require "rails_helper"

RSpec.feature "Editing a post comment" do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user1) }
  let!(:comment) { FactoryBot.create(:comment, user: user1, post: post) }

  describe "a signed in user" do
    scenario "edits his comment" do
      login_as(user1, scope: :user)
      visit "/"
      click_link post.title
      find("a[href='#{edit_post_comment_path(post, comment)}']").click
      fill_in "Body", with: "Updated body"
      click_button "Update Comment"

      expect(page).to have_content "Comment updated successfully!"
      expect(page).to have_content "Updated body"
      expect(current_path).to eq(post_path(post))
    end

    scenario "can't edit someone else's comment" do
      login_as(user2, scope: :user)
      visit "/"
      click_link post.title

      expect(page).not_to have_link("Edit", href: edit_post_comment_path(post, comment))
      expect(current_path).to eq(post_path(post))
    end
  end

  describe "an anonymous user" do
    scenario "can't edit someone's comment" do
      visit "/"
      click_link post.title

      expect(page).not_to have_link("Edit", href: edit_post_comment_path(post, comment))
      expect(current_path).to eq(post_path(post))
    end
  end
end
