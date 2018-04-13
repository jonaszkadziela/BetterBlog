require "rails_helper"

RSpec.feature "Deleting a post" do
  before(:each) do
    @user = FactoryBot.create(:user)
    login_as(@user, :scope => :user)
  end

  let!(:post) { FactoryBot.create(:post) }

  scenario "A user deletes a post" do
    visit "/"

    click_link post.title
    click_link "Delete"

    expect(page).to have_content("Post deleted successfully!")
    expect(current_path).to eq(posts_path)
  end
end