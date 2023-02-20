# frozen_string_literal: true

class Post::PostComponent < ViewComponent::Base
  def initialize(posts:)
    @posts = posts
  end
end
