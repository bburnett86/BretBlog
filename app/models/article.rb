class Article < ActiveRecord::Base
  include ActiveModel::Validations

  validates_presence_of :content
  validates_presence_of :title

  has_many :comments
  belongs_to :user

  def self.previous_article(type, current_id)
    if type == "blog_post"
      type = {blog_post: true}
    elsif type == "project"
      type = {project: true}
    else
      type = {blog_post: true}
    end

    pluck_index = Article.where(type).pluck(:id).sort.index(current_id.to_i)-1
    prev_id = Article.where(type).pluck(:id)[pluck_index]
    return Article.find(prev_id)

  end

  def self.next_article(type, current_id)
    if type == "blog_post"
      type = {blog_post: true}
    elsif type == "project"
      type = {project: true}
    else
      type = {blog_post: true}
    end

    pluck_index = Article.where(type).pluck(:id).sort.index(current_id.to_i)+1
    next_id = Article.where(type).pluck(:id)[pluck_index]
    if next_id.nil?
      return Article.last
    else
      return Article.find(next_id)
    end
  end

end