require "rails_helper"

RSpec.describe User, type: :model do
  context "必要な情報が揃っているとき" do
    let(:user) { build(:user) }
    it "ユーザー登録できる" do
      expect(user).to be_valid
    end
  end

  context "ユーザーネームがないとき" do
    let(:user) { build(:user, name: nil) }
    it "ユーザーの作成に失敗する" do
      expect(user).to be_invalid
      expect(user.errors.details[:name][0][:error]).to eq :blank
    end
  end

  context "メールアドレスがないとき" do
    let(:user) { build(:user, email: nil) }
    it "ユーザーの作成に失敗する" do
      expect(user).to be_invalid
      expect(user.errors.details[:email][0][:error]).to eq :blank
    end
  end

  context "passwordがないとき" do
    let(:user) { build(:user, password: nil) }
    it "ユーザーの作成に失敗する" do
      expect(user).to be_invalid
      expect(user.errors.details[:password][0][:error]).to eq :blank
    end
  end

  context "password確認が違うとき" do
    let(:user) { build(:user, password_confirmation: "hoge") }
    it "ユーザーの作成に失敗する" do
      expect(user).to be_invalid
      expect(user.errors.details[:password_confirmation][0][:error]).to eq :confirmation
    end
  end
end
