require "rails_helper"

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.build(:post) }

  describe "validation tests" do
    context "for title" do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_most(50) }
    end

    context "for body" do
      it { should validate_presence_of(:body) }
    end

    it "should save successfully" do
      expect(post.save).to eq(true)
    end
  end

  describe "association tests" do
    it { should belong_to(:user).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end
end