require "rails_helper"

RSpec.feature "Creating a comment to post" do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user1) }
  let(:comment) { FactoryBot.build(:comment) }

  scenario "a signed in user creates a comment" do
    login_as(user2, :scope => :user)
    visit "/"
    click_link post.title
    fill_in "Body", with: comment.body
    click_button "Create Comment"

    expect(Comment.last.user).to eq(user2)
    expect(page).to have_content("Comment created successfully!")
    expect(page).to have_content(user2.username)
    expect(page).to have_content(comment.body)
    expect(current_path).to eq(post_path(post.id))
  end
end