class ArticlesController < ApplicationController
  include SessionHelper

  def home
    render :home
  end

  def about_me
    @article = Article.find_by(about_me: true)
    render :about_me
  end

  def index
    @about_me = Article.find_by(about_me: true)

    @blogs = Article.where(blog_post: true)
    if @blogs.count > 1
      @blogs = @blogs.reverse_order
    end

    @projects =Article.where(project: true)
    if Article.where(project: true).count > 1
      @projects = @projects.reverse_order
    end
    render :index
  end

  def create
    @article = Article.new(title: params[:title], content: params[:content], blog_post: params[:blog_post], project: params[:project], about_me: params[:about_me], pic_url: params[:pic_url])
    if @article.save
      redirect_to articles_path
    else
      @errors = "Missing Title or Content"
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    render :edit
  end

  def update
    article = Article.find(params[:id])
    article.assign_attributes(title: params[:title], content: params[:content], pic_url: params[:pic_url])
    if article.save
      redirect_to articles_path
    else
      @errors = article.errors.full_messages
      render :edit
    end
  end


  def delete
    blog = Article.find(params[:id])
    blog.delete
    redirect_to articles_path
  end
end
