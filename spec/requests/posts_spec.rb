require "rails_helper"

RSpec.describe "Posts", type: :request do
  before do
    @post = FactoryBot.create(:post)
  end

  describe "GET /posts/:id" do
    context "with existing post" do
      before { get "/posts/#{@post.id}" }

      it "handles existing post" do
        expect(response.status).to eq 200
      end
    end

    context "with non-existing post" do
      before { get "/posts/x" }

      it "handles non-existing post" do
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "The post you are looking for could not be found."
      end
    end
  end
end