require "rails_helper"

RSpec.feature "A user signs in" do
  let(:user) { FactoryBot.create(:user) }

  context "using email" do
    include_examples "sign in user", :email
  end

  context "using username" do
    include_examples "sign in user", :username
  end
end