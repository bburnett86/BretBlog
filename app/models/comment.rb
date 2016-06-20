class Comment < ActiveRecord::Base
  include ActiveModel::Validations

  validates_presence_of :content

  belongs_to :user
  belongs_to :article
  belongs_to :commenter, class_name: "User"

end
