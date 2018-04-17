require "rails_helper"

RSpec.feature "Deleting a post" do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user1) }

  describe "a signed in user" do
    scenario "deletes his post" do
      login_as(user1, :scope => :user)
      visit "/"
      click_link post.title
      click_link "Delete"

      expect(page).to have_content "Post deleted successfully!"
      expect(current_path).to eq(posts_path)
    end

    scenario "can't delete someone else's post" do
      login_as(user2, :scope => :user)
      visit "/"
      click_link post.title

      expect(page).not_to have_link("Delete", href: post_path(post))
      expect(current_path).to eq(post_path(post))
    end
  end

  describe "an anonymous user" do
    scenario "can't delete someone's post" do
      visit "/"
      click_link post.title

      expect(page).not_to have_link("Delete", href: post_path(post))
      expect(current_path).to eq(post_path(post))
    end
  end
end