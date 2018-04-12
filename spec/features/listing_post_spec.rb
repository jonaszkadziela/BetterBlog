require "rails_helper"

RSpec.feature "Listing posts" do
  before do
    @post_1 = Post.create(title: "First post title", body: "First post body")
    @post_2 = Post.create(title: "Second post title", body: "Second post body")
  end

  scenario "A user lists all posts" do
    visit "/"

    expect(page).to have_content(@post_1.title)
    expect(page).to have_content(@post_1.body)
    expect(page).to have_content(@post_2.title)
    expect(page).to have_content(@post_2.body)
    
    expect(page).to have_link(@post_1.title)
    expect(page).to have_link(@post_2.title)
  end

  scenario "A user sees no posts" do
    Post.delete_all

    visit "/"

    expect(page).not_to have_content(@post_1.title)
    expect(page).not_to have_content(@post_1.body)
    expect(page).not_to have_content(@post_2.title)
    expect(page).not_to have_content(@post_2.body)
    
    expect(page).not_to have_link(@post_1.title)
    expect(page).not_to have_link(@post_2.title)

    expect(page).to have_content("There are no posts created yet")
  end
end