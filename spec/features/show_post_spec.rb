require "rails_helper"

RSpec.feature "Showing single post" do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user1) }

  scenario "to anonymous user" do
    visit "/"
    click_link post.title

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.body)
    expect(page).not_to have_link("Edit")
    expect(page).not_to have_link("Delete")
    expect(current_path).to eq(post_path(post))
  end

  scenario "to user who does not own the post" do
    login_as(user2, :scope => :user)
    visit "/"
    click_link post.title

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.body)
    expect(page).not_to have_link("Edit")
    expect(page).not_to have_link("Delete")
    expect(current_path).to eq(post_path(post))
  end

  scenario "to user who owns the post" do
    login_as(user1, :scope => :user)
    visit "/"
    click_link post.title

    expect(page).to have_content(post.title)
    expect(page).to have_content(post.body)
    expect(page).to have_link("Edit")
    expect(page).to have_link("Delete")
    expect(current_path).to eq(post_path(post))
  end
end