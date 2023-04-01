class Post < ApplicationRecord
    has_many_attached :images

    belongs_to :user
    has_many :comments, dependent: :destroy

    validates :body, presence: true

    # after_create_commit { broadcast_append_to "posts"}

    # after_save :broadcast_post_creation



    # def broadcast_post_creation
    #     # ActionCable.server.broadcast("post_channel", { type: "post_created", post: self })
    #     # ActionCable.server.broadcast("post_channel", { type: "posts_updated", posts: Post.all })
    #     broadcast_append_to("post_channel", {post: self})
    #
    # end

    after_create_commit { broadcast_prepend_to "post_channel", partial: "posts/post", target:"post_channel", locals: { post: self } }
end
