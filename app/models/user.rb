class User < ActiveRecord::Base
  include ActiveModel::Validations

  has_secure_password

  has_many :articles
  has_many :comments, through: :articles
  has_many :created_comments, class_name: "Comment", foreign_key: "commenter_id"

  validates_presence_of :username
  validates_presence_of :email

  def self.authenticate(username, password)
    user = User.find_by(username: username)
    return user if user && user.password == password
  end
end
