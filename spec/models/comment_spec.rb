require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.build(:comment) }

  describe "validation tests" do
    context "for body" do
      it { should validate_presence_of(:body) }
    end

    it "should save successfully" do
      expect(comment.save).to eq(true)
    end
  end

  describe "association tests" do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
