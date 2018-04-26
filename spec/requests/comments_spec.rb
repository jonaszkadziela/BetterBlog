require "rails_helper"

RSpec.describe "Comments", type: :request do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post1) { FactoryBot.create(:post, user: user1) }
  let!(:comment1) { FactoryBot.create(:comment, post: post1, user: user1) }
  let(:comment_attributes) { FactoryBot.attributes_for(:comment) }

  describe "POST #create" do
    context "with anonymous user" do
      it do
        expect {
          post "/posts/#{post1.id}/comments", params: { comment: comment_attributes }
        }.to_not change(Comment, :count)
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with valid user" do
      before { login_as(user1) }

      it do
        expect {
          post "/posts/#{post1.id}/comments", params: { comment: comment_attributes }
        }.to change(Comment, :count).by(1)
        expect(response).to redirect_to(post_path(post1.id))
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq "Comment created successfully!"
      end
    end
  end

  describe "PUT #update" do
    context "with anonymous user" do
      before { put "/posts/#{post1.id}/comments/#{comment1.id}", params: { comment: comment_attributes } }

      it do
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with invalid user" do
      before do
        login_as(user2)
        put "/posts/#{post1.id}/comments/#{comment1.id}", params: { comment: comment_attributes }
      end
      
      it do
        expect(response).to redirect_to(post_path(post1))
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You can only edit your own comments!"
      end
    end

    context "with valid user" do
      before do
        login_as(user1)
        put "/posts/#{post1.id}/comments/#{comment1.id}", params: { comment: comment_attributes }
      end
      
      it do
        expect(response).to redirect_to(post_path(post1))
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq "Comment updated successfully!"
      end
    end
  end

  describe "DELETE #destroy" do
    context "with anonymous user" do
      it do
        expect {
          delete "/posts/#{post1.id}/comments/#{comment1.id}"
        }.to_not change(Comment, :count)
        expect(response).to redirect_to(new_user_session_path)
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with invalid user" do
      before { login_as(user2) }

      it do
        expect {
          delete "/posts/#{post1.id}/comments/#{comment1.id}"
        }.to_not change(Post, :count)
        expect(response).to redirect_to(post_path(post1))
        expect(response).to have_http_status(302)
        expect(flash[:alert]).to eq "You can only delete your own comments!"
      end
    end

    context "with valid user" do
      before { login_as(user1) }
      
      it do
        expect {
          delete "/posts/#{post1.id}/comments/#{comment1.id}"
        }.to change(Comment, :count).by(-1)
        expect(response).to redirect_to(post_path(post1))
        expect(response).to have_http_status(302)
        expect(flash[:notice]).to eq "Comment deleted successfully!"
      end
    end
  end
end