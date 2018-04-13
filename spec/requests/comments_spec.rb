require "rails_helper"

RSpec.describe "Comments", type: :request do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post1) { FactoryBot.create(:post, user: user1) }
  let(:comment) { FactoryBot.build(:comment) }

  describe "POST /articles/:id/comments" do
    context "with anonymous user" do
      before do
        post "/posts/#{post1.id}/comments", params: { comment: { body: comment.body } }
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to(new_user_session_path)
        expect(response.status).to eq 302
        expect(flash[:alert]).to eq "You need to sign in or sign up before continuing."
      end
    end

    context "with signed in user" do
      before do
        login_as(user1)
        post "/posts/#{post1.id}/comments", params: { comment: { body: comment.body } }
      end

      it "create comment successfully" do
        expect(response).to redirect_to(post_path(post1.id))
        expect(response.status).to eq 302
        expect(flash[:notice]).to eq "Comment created successfully!"
      end
    end
  end
end