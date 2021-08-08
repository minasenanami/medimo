class ArticlesController < ApplicationController
  before_action :correct_user, only: [:edit]
  before_action :set_edit_article, only: %i[edit update destroy]
  before_action :authenticate_user!, only: %i[create update destroy]

  def index
    @q = Article.published.ransack(params[:q])
    @search_articles = @q.result.page(params[:page]).per(PER_PAGE)
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)
    @tag_list = params[:article][:tag_name].split(/[[:blank:]]/)

    if @article.save
      @article.save_tag(@tag_list)
      case @article.status
      when "published"
        redirect_to article_path(@article)
      when "draft"
        redirect_to articles_draft_path(@article)
      when "closed"
        redirect_to articles_close_path(@article)
      end
    else
      flash.now[:alert] = "タイトルを記入してください"
      render :new
    end
  end

  def edit
    if @article.user == current_user
      @tag_list = @article.tags.pluck(:tag_name).join(" ")
      render :edit
    else
      redirect_to root_path, alert: "記事の編集はできません"
    end
  end

  def show
    @article = Article.published.find(params[:id])
    @article_tags = @article.tags
  end

  def update
    tag_list = params[:article][:tag_name].split(/[[:blank:]]/)
    if @article.update(article_params)
      @article.save_tag(tag_list)

      case @article.status
      when "published"
        redirect_to article_path(@article)
      when "draft"
        redirect_to articles_draft_path(@article)
      when "closed"
        redirect_to articles_close_path(@article)
      end
    else
      flash.now[:alert] = "タイトルを記入してください"
      render :edit
    end
  end

  def destroy
    @article.destroy!
    redirect_to mypage_path(current_user)
  end

  def search
    @tag = Tag.find(params[:tag_id])
    @articles = @tag.articles.published.order(updated_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  private

    def article_params
      params.require(:article).permit(:title, :content, :images, :status)
    end

    def set_edit_article
      @article = current_user.articles.find(params[:id])
    end

    def correct_user
      @article = current_user.articles.find_by(id: params[:id])
      unless @article
        redirect_to root_path, alert: "指定した記事は閲覧できません"
      end
    end
end
