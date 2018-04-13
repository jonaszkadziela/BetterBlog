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

  describe "DELETE /posts/:id/" do
    context "with anonymous user" do
      before { delete "/posts/#{post.id}/" }

      it "redirects to the sign in page" do
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with user who does not own the post" do
      before do
        login_as(user2)
        delete "/posts/#{post.id}/"
      end

      it "redirects to the home page" do
        expect(response).to redirect_to(root_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You can only delete your own posts!"
      end
    end

    context "with user who owns the post" do
      before do
        login_as(user1)
        delete "/posts/#{post.id}/"
      end

      it "successfully deletes post" do
        expect(response.status).to eq 302
      end
    end
  end

  describe "GET /posts/:id/edit" do
    context "with anonymous user" do
      before { get "/posts/#{post.id}/edit" }

      it "redirects to the sign in page" do
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with user who does not own the post" do
      before do
        login_as(user2)
        get "/posts/#{post.id}/edit"
      end

      it "redirects to the home page" do
        expect(response).to redirect_to(root_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You can only edit your own posts!"
      end
    end

    context "with user who owns the post" do
      before do
        login_as(user1)
        get "/posts/#{post.id}/edit"
      end

      it "successfully gets edit post page" do
        expect(response.status).to eq 200
      end
    end
  end
end