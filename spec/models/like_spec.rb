require "rails_helper"

RSpec.describe Like, type: :model do
  context "データが条件を満たすとき" do
    let(:like) { build(:like) }
    it "保存できる" do
      expect(like).to be_valid
    end
  end

  context "article_id がすでに存在するとき" do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    let!(:first_like) { create(:like, user: user, article: article) }
    let(:second_like) { build(:like, user: user, article: article) }
    it "いいねに失敗する" do
      expect(second_like).to be_invalid
      expect(second_like.errors.details[:user_id][0][:error]).to eq :taken
    end
  end
end
