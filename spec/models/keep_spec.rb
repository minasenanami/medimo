require "rails_helper"

RSpec.describe Keep, type: :model do
  context "データが条件を満たすとき" do
    let(:keep) { build(:keep) }
    it "保存できる" do
      expect(keep).to be_valid
    end
  end

  context "article_id がすでに存在するとき" do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    let!(:first_keep) { create(:keep, user: user, article: article) }
    let(:second_keep) { build(:keep, user: user, article: article) }
    it "保存に失敗する" do
      expect(second_keep).to be_invalid
      expect(second_keep.errors.details[:user_id][0][:error]).to eq :taken
    end
  end
end
