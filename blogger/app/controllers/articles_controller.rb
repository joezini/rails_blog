class ArticlesController < ApplicationController
  include ArticlesHelper

  before_filter :require_login, except: [:show, :index]

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    @article.views = @article.views + 1
    @article.save

    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.author_email = current_user.email
    @article.views = 0
    @article.save

    flash.notice = "Article '#{@article.title}' Created!"

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])

    if user_is_author?
      @article.destroy
      flash.notice = "Article '#{@article.title}' Deleted!"
      redirect_to articles_path
    else
      flash.notice = "Only the original author can delete the article"
      redirect_to article_path(@article)
    end
  end

  def edit
    @article = Article.find(params[:id])

    if !user_is_author?
      flash.notice = "Only the original author can edit the article"
      redirect_to article_path(@article)
    end
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end

  def popular
    @articles = Article.order(views: :desc).limit(3)
  end

  def feed
    @articles = Article.all
    respond_to do |format|
      format.rss {render :layout => false}
    end
  end

  def user_is_author?
    @article.author_email == current_user.email
  end
end
