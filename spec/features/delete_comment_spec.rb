require "rails_helper"

RSpec.feature "Deleting a post comment" do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user1) }
  let!(:comment) { FactoryBot.create(:comment, user: user1, post: post) }

  describe "a signed in user" do
    scenario "deletes his comment" do
      login_as(user1, scope: :user)
      visit "/"
      click_link post.title
      find("a[href='#{post_comment_path(post, comment)}']").click

      expect(page).to have_content "Comment deleted successfully!"
      expect(page).not_to have_content comment.body
      expect(current_path).to eq(post_path(post))
    end

    scenario "can't delete someone else's comment" do
      login_as(user2, scope: :user)
      visit "/"
      click_link post.title

      expect(page).not_to have_link("Delete", href: post_comment_path(post, comment))
      expect(current_path).to eq(post_path(post))
    end
  end

  describe "an anonymous user" do
    scenario "can't delete someone's comment" do
      visit "/"
      click_link post.title

      expect(page).not_to have_link("Delete", href: post_comment_path(post, comment))
      expect(current_path).to eq(post_path(post))
    end
  end
end
