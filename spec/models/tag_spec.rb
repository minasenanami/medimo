require "rails_helper"

RSpec.describe Tag, type: :model do
  context "タグが入力されている時" do
    let(:tag) { build(:tag) }
    it "タグが生成できる" do
      expect(tag).to be_valid
    end
  end

  context "タグが空欄のとき" do
    let(:tag) { build(:tag, tag_name: nil) }
    it "保存に失敗する" do
      expect(tag).to be_invalid
      expect(tag.errors.details[:tag_name][0][:error]).to eq :blank
    end
  end
end
