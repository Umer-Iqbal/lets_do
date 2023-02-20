# frozen_string_literal: true

class Comment::CommentComponent < ViewComponent::Base
  def initialize(comment:, current_user:)
    @comment = comment
    @current_user = current_user
  end
end
