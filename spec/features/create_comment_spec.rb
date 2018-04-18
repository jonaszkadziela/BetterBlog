require "rails_helper"

RSpec.feature "Creating a comment to post" do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user) }
  let(:comment) { FactoryBot.build(:comment) }

  describe "a signed in user" do
    before(:each) do
      login_as(user, :scope => :user)
      visit "/"
      click_link post.title
    end

    scenario "creates a comment" do
      fill_in "Body", with: comment.body
      click_button "Create Comment"

      expect(Comment.last.user).to eq(user)
      expect(page).to have_content("Comment created successfully!")
      expect(page).to have_content(user.username)
      expect(page).to have_content(comment.body)
      expect(current_path).to eq(post_path(post))
    end

    scenario "fails to create a comment" do
      fill_in "Body", with: ""
      click_button "Create Comment"

      expect(page).to have_content("prevented this comment from being saved:")
      expect(page).to have_content("Body can't be blank")
      expect(current_path).to eq(post_path(post) + "/comments")
    end
  end

  describe "an anonymous user" do
    scenario "tries to create a comment" do
      visit "/"
      click_link post.title
      fill_in "Body", with: comment.body
      click_button "Create Comment"

      expect(page).to have_content("You need to sign in or sign up before continuing.")
      expect(current_path).to eq(new_user_session_path)
    end
  end
end