require "rails_helper"

RSpec.describe Article, type: :model do
  describe "正常系" do
    context "タイトルと本文が存在するとき" do
      let(:article) { build(:article) }
      it "公開状態で記事が作成される" do
        expect(article.content.body.present?).to eq true
        expect(article.status).to eq "published"
        expect(article).to be_valid
      end
    end

    context "必要情報が記載されstatusがpublishedのとき" do
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

    context "statusがdraft" do
      context "contentがnilでも" do
        let(:article) { build(:article, :draft, content: nil) }
        it "下書き記事を作成できる" do
          expect(article).to be_valid
          expect(article.status).to eq "draft"
        end
      end
    end

    context "statusがclosed" do
      context "contentがnilでも" do
        let(:article) { build(:article, :closed, content: nil) }
        it "非公開記事を作成できる" do
          expect(article).to be_valid
          expect(article.status).to eq "closed"
        end
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

    context "公開記事のcontentが無いとき" do
      let(:article) { build(:article, :published, content: nil) }
      it "公開記事の作成に失敗する" do
        expect(article.content.body.blank?).to eq true
        expect(article).to be_invalid
        expect(article.errors.details[:content][0][:error]).to eq :blank
      end
    end

    context "statusがないとき" do
      let(:article) { build(:article, status: nil) }
      it "記事の作成に失敗する" do
        expect(article).to be_invalid
        expect(article.errors.details[:status][0][:error]).to eq :blank
      end
    end
  end
end
