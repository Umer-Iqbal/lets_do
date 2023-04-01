class Post < ApplicationRecord
    has_many_attached :images

    belongs_to :user
    has_many :comments, dependent: :destroy

    validates :body, presence: true

    after_create_commit do
      # broadcast_prepend_later_to :stream_name, target: 'wrapper_id_in_which_all_posts_will_rendered', partial: 'partial/in/which/self/will/place/then/this/partial/will/place', locals: { post: self }     #faster but may be little delay for some user

      # broadcast_prepend_to :posts_list, target: 'all_posts', partial: 'posts/post', locals: { post: self }   #for imigate add to all user but slow down the server
      broadcast_prepend_later_to :posts_list, target: 'all_posts', partial: 'posts/post', locals: { post: self }     #faster but may be little delay for some user
    end

    after_update_commit {broadcast_replace_later_to :posts_list, target: self, partial: 'posts/post', locals: { post: self } }
    after_destroy_commit {broadcast_remove_to :posts_list, target: self }  #dont add later init
end
