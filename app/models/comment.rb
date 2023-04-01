class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :body, presence: true
  validates :post, presence: true
  validates :user, presence: true


  # after_create_commit do
  #   broadcast_prepend_later_to("comments_list", target: 'all_comments',
  #                             html: ApplicationController.render(Comment::CommentComponent.new(comment: self), layout: false))
  # end
end
