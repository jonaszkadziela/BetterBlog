require "rails_helper"

RSpec.describe "Posts", type: :request do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post1) { FactoryBot.create(:post, user: user1) }
  let(:post_attributes) { FactoryBot.attributes_for(:post) }

  describe "GET #index" do
    before { get "/posts/" }

    it do
      expect(path).to eq(posts_path)
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #show" do
    context "with valid post" do
      before { get "/posts/#{post1.id}" }

      it do
        expect(path).to eq(post_path(post1))
        expect(response).to have_http_status(200)
      end
    end

    context "with invalid post" do
      before { get "/posts/x" }

      it do
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "The post you are looking for could not be found."
      end
    end
  end

  describe "GET #new" do
    context "with anonymous user" do
      before { get "/posts/new" }

      it do
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with valid user" do
      before do
        login_as(user1)
        get "/posts/new"
      end

      it do
        expect(path).to eq(new_post_path)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #edit" do
    context "with anonymous user" do
      before { get "/posts/#{post1.id}/edit" }

      it do
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with invalid user" do
      before do
        login_as(user2)
        get "/posts/#{post1.id}/edit"
      end

      it do
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You can only edit your own posts!"
      end
    end

    context "with valid user" do
      before do
        login_as(user1)
        get "/posts/#{post1.id}/edit"
      end

      it do
        expect(path).to eq(edit_post_path)
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "POST #create" do
    context "with anonymous user" do
      it do
        expect {
          post "/posts/", params: { post: post_attributes }
        }.to_not change(Post, :count)
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with valid user" do
      before { login_as(user1) }

      it do
        expect {
          post "/posts/", params: { post: post_attributes }
        }.to change(Post, :count).by(1)
        expect(response).to redirect_to(Post.last)
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq "Post created successfully!"
      end
    end
  end

  describe "PUT #update" do
    context "with anonymous user" do
      before { put "/posts/#{post1.id}/", params: { post: post_attributes } }

      it do
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with invalid user" do
      before do
        login_as(user2)
        put "/posts/#{post1.id}/", params: { post: post_attributes }
      end

      it do
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You can only edit your own posts!"
      end
    end

    context "with valid user" do
      before do
        login_as(user1)
        put "/posts/#{post1.id}/", params: { post: post_attributes }
      end

      it do
        expect(response).to redirect_to(post_path(post1))
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq "Post updated successfully!"
      end
    end
  end

  describe "DELETE #destroy" do
    context "with anonymous user" do
      it do
        expect {
          delete "/posts/#{post1.id}/"
        }.to_not change(Post, :count)
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with invalid user" do
      before { login_as(user2) }

      it do
        expect {
          delete "/posts/#{post1.id}/"
        }.to_not change(Post, :count)
        expect(response).to redirect_to(root_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You can only delete your own posts!"
      end
    end

    context "with valid user" do
      before { login_as(user1) }

      it do
        expect {
          delete "/posts/#{post1.id}/"
        }.to change(Post, :count).by(-1)
        expect(response).to redirect_to(posts_path)
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq "Post deleted successfully!"
      end
    end
  end
end
