require "rails_helper"

RSpec.describe TagMap, type: :model do
  describe "正常系" do
    context "article_id と tag_idが存在するとき" do
      let(:tag_map) { create(:tag_map) }
      it "有効である" do
        expect(tag_map).to be_valid
      end
    end
  end

  describe "異常系" do
    context "article_idが存在しない時" do
      let(:tag_map) { build(:tag_map, article_id: nil) }
      it "エラーする" do
        expect(tag_map).to be_invalid
        expect(tag_map.errors.details[:article][0][:error]).to eq :blank
      end
    end

    context "tag_idが存在しない時" do
      let(:tag_map) { build(:tag_map, tag_id: nil) }
      it "エラーする" do
        expect(tag_map).to be_invalid
        expect(tag_map.errors.details[:tag][0][:error]).to eq :blank
      end
    end
  end
end
