require "rails_helper"

RSpec.feature "Show post" do
  before do
    @post = FactoryBot.create(:post)
  end

  scenario "A user shows a post" do
    visit "/"

    click_link @post.title

    expect(page).to have_content(@post.title)
    expect(page).to have_content(@post.body)

    expect(current_path).to eq(post_path(@post))
  end
end