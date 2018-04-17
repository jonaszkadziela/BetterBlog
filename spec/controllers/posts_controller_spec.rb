require "rails_helper"

RSpec.describe PostsController, type: :controller do
  let(:user1) { FactoryBot.create(:user) }
  let(:user2) { FactoryBot.create(:user) }
  let!(:post) { FactoryBot.create(:post, user: user1) }
  let(:valid_session) { sign_in user1 }
  let(:invalid_session) { sign_in user2 }

  describe "GET #index" do
    before { get :index }
    
    it { should render_template("index") }
  end

  describe "GET #show" do
    before { get :show, params: { id: post.id } }
    
    it { should render_template("show") }
  end

  describe "GET #new" do
    context "with valid session" do
      before { get :new, session: valid_session }
      
      it { should render_template("new") }
    end

    context "with anonymous session" do
      before { get :new }
      
      it do
        should redirect_to new_user_session_path
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end

  describe "GET #edit" do
    context "with valid session" do
      before { get :edit, params: { id: post.id }, session: valid_session }
      
      it { should render_template("edit") }
    end

    context "with invalid session" do
      before { get :edit, params: { id: post.id }, session: invalid_session }
      
      it do
        should redirect_to root_path
        expect(flash[:alert]).to eq("You can only edit your own posts!")
      end
    end

    context "with anonymous session" do
      before { get :edit, params: { id: post.id } }
      
      it do
        should redirect_to new_user_session_path
        expect(flash[:alert]).to eq("You need to sign in or sign up before continuing.")
      end
    end
  end
end