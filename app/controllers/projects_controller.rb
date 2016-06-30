class ProjectsController < ApplicationController
  include SessionHelper

  def index
    @articles = Article.where(project: true).reverse_order
    render :index
  end

  def show
    @article = Article.find(params[:id])
    @previous_article = Article.previous_article("project", params[:id])
    @next_article = Article.next_article("project", params[:id])
    @first_article = Article.where(project: true).sort.first
    @last_article = Article.where(project: true).sort.last

    if request.xhr?
      render :_show, layout: false, locals:{article: @article}
    else
      render :show
    end
  end

  def new
    @article = Article.new
    render :show
  end

  def create
    @article = Article.new(title: params[:title], content: params[:content], project: true)
    if @article.save
      redirect_to(:root)
    else
      @errors = @user.errors.full_messages
      render :new
    end
  end

end
