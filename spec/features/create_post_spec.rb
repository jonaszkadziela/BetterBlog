require "rails_helper"

RSpec.feature "Creating a post" do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.build(:post) }

  before(:each) do
    login_as(user, :scope => :user)
    visit "/"
    click_link "New post"
  end

  scenario "A user creates a new post" do
    fill_in "Title", with: post.title
    fill_in "Body", with: post.body
    click_button "Create Post"

    expect(Post.last.user).to eq(user)
    expect(page).to have_content("Post created successfully!")
    expect(page).to have_content(post.title)
    expect(page).to have_content(post.body)
    expect(page).to have_content(user.username)
  end

  scenario "A user fails to create a new post" do
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Create Post"

    expect(page).to have_content("prevented this post from being saved:")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end