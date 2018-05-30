require "rails_helper"

RSpec.feature "Listing many posts" do
  let!(:post1) { FactoryBot.create(:post) }
  let!(:post2) { FactoryBot.create(:post) }

  scenario "A user lists all posts" do
    visit "/"

    expect(page).to have_content(post1.title)
    expect(page).to have_content(post1.body)
    expect(page).to have_content(post2.title)
    expect(page).to have_content(post2.body)
    expect(page).to have_link(post1.title)
    expect(page).to have_link(post2.title)
  end

  scenario "A user sees no posts" do
    Post.delete_all
    visit "/"

    expect(page).to have_content("There are no posts created yet")
  end
end
