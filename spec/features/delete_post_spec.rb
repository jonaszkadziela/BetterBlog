require "rails_helper"

RSpec.feature "Deleting a post" do
  let(:user) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user) }

  before do
    login_as(user, :scope => :user)
  end

  scenario "A user deletes a post" do
    visit "/"
    click_link post.title
    click_link "Delete"

    expect(page).to have_content("Post deleted successfully!")
    expect(current_path).to eq(posts_path)
  end
end