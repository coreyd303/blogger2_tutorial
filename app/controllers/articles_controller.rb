class ArticlesController < ApplicationController
  include ArticlesHelper

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params) #note this method comes from ArticlesHelper

    # @article.title = params[:article][:title] above you can see that we jsut pass in the whole hash
    # @article.body  = params[:article][:body]
    flash.notice = "Holy cow! Look at you, you made a new article: '#{@article.title}'"

    @article.save
    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    flash.notice = "The article '#{@article.title}' has been obliterated!"
    
    redirect_to articles_path(@article)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)

    flash.notice = "The article '#{@article.title}' was updated at '#{Time.now}'!"

    redirect_to article_path(@article)
  end
end
