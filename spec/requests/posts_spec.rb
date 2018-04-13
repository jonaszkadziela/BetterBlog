require "rails_helper"

RSpec.describe "Posts", type: :request do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user1) }

  describe "GET /posts/:id" do
    context "with existing post" do
      before { get "/posts/#{post.id}" }

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

  describe "GET /posts/:id/edit" do
    context "with anonymous user" do
      it "redirects to the sign in page" do
        get "/posts/#{post.id}/edit"
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with user who does not own the post" do
      it "redirects to the home page" do
        login_as(user2)
        get "/posts/#{post.id}/edit"
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You can only edit you own posts!"
      end
    end

    context "with user who owns the post" do
      it "successfully gets edit post page" do
        login_as(user1)
        get "/posts/#{post.id}/edit"
        expect(response.status).to eq 200
      end
    end
  end
end