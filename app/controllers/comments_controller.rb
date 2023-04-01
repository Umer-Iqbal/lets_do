class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: [:edit, :update, :destroy]

  def index
    @user = current_user
    @comments = @post.comments.order("created_at DESC")
  end

  def create
    @comment = Comment.new
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      update_posts_count
      Turbo::StreamsChannel.broadcast_prepend_later_to(:comments_list, target: 'all_comments',
                                   html: ApplicationController.render(Comment::CommentComponent.new(comment: @comment, current_user: current_user), layout: false))
      head 200
      # redirect_to post_comments_path(@post), notice: "Comment was successfully created."
    else
      redirect_to post_comments_path(@post), alert: "Comment was not created."
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      Turbo::StreamsChannel.broadcast_replace_later_to(:comments_list, target: "comment_#{@comment.id}",
                                   html: ApplicationController.render(Comment::CommentComponent.new(comment: @comment, current_user: current_user),  layout: false))
      head 200

      # redirect_to post_comments_path(@post), notice: "Comment was successfully updated."
    else
      render :edit, alert: "Comment was not updated."
    end
  end

  def destroy
    if @comment.destroy
      update_posts_count
      Turbo::StreamsChannel.broadcast_remove_to(:comments_list, target: "comment_#{@comment.id}")
      head 200
    end
    # redirect_to @post, notice: "Comment was successfully destroyed."
  end

  private
  def update_posts_count
    Turbo::StreamsChannel.broadcast_update_to :posts_list, target: "post_#{@post.id}_comments_count", html: @post.comments.count
    # Turbo::StreamsChannel.broadcast_update_to :posts_list, target: 'comments_count', partial: 'posts/count', locals: { count: Post.count }
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
