class BlogsController < ApplicationController
  include SessionHelper
  include ArticlesHelper

  def index
    @articles = Article.where(blog_post: true)
    render :index
  end

  def show
    @article = Article.find(params[:id])
    @previous_article = Article.previous_article("blog_post", params[:id])
    @next_article = Article.next_article("blog_post", params[:id])
    @first_article = Article.where(blog_post: true).sort.first
    @last_article = Article.where(blog_post: true).sort.last

    if request.xhr?
      render :_show, layout: false, locals:{article: @article}
    else
      render :show
    end
  end

  def new
    @article = Article.new
    render :new
  end

  def create
    @article = Article.new(title: params[:title], content: params[:content], blog_post: true)
    if @article.save
      if request.xhr?
        render :_new_article, layout: false, locals:{article: @article}
      else
        redirect_to
      end
    else
      if request.xhr?
        @errors = @user.errors.full_messages
        redirect_to :_new_article, layout: false, locals:{article: @article, errors: @errors}
      else
        @errors = @user.errors.full_messages
        redirect_to(:new)
      end
    end
  end

end
