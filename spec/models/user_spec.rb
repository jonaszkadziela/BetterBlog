require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe "validation tests" do
    context "for username" do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username).case_insensitive }
      it { should validate_length_of(:username).is_at_least(4).is_at_most(20) }
      it { should_not allow_value("test!@#").for(:username).on(:create) }
    end

    context "for email" do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end

    context "for password" do
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(6).is_at_most(128) }
    end

    it "should save successfully" do
      expect(user.save).to eq(true)
    end
  end

  describe "association tests" do
    it { should have_many(:posts) }
    it { should have_many(:comments) }
  end
end
