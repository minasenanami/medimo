require "rails_helper"

RSpec.describe Article, type: :model do
  describe "正常系" do
    context "タイトルと本文と公開レベルが指定されているとき" do
      let(:article) { build(:article) }
      it "公開状態で記事が作成される" do
        expect(article).to be_valid
        expect(article.status).to eq "published"
      end
    end

    context "statusがpublishedのとき" do
      let(:article) { build(:article, :published) }
      it "公開状態で記事を作成できる" do
        expect(article).to be_valid
        expect(article.status).to eq "published"
      end
    end

    context "statusがdraftのとき" do
      let(:article) { build(:article, :draft) }
      it "下書き状態で記事を作成できる" do
        expect(article).to be_valid
        expect(article.status).to eq "draft"
      end
    end

    context "statusがclosedのとき" do
      let(:article) { build(:article, :closed) }
      it "非公開状態で記事を作成できる" do
        expect(article).to be_valid
        expect(article.status).to eq "closed"
      end
    end
  end

  describe "異常系" do
    context "titleが無いとき" do
      let(:article) { build(:article, title: nil) }
      it "記事の作成に失敗する" do
        expect(article).to be_invalid
        expect(article.errors.details[:title][0][:error]).to eq :blank
      end
    end

    context "contentが無いとき" do
      let(:article) { build(:article, content: nil) }
      it "記事の作成に失敗する" do
        expect(article).to be_invalid
        expect(article.errors.details[:content][0][:error]).to eq :blank
      end
    end
  end
end
