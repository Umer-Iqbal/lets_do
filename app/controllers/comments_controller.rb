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
      redirect_to post_comments_path(@post), notice: "Comment was successfully created."
    else
      redirect_to post_comments_path(@post), alert: "Comment was not created."
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_comments_path(@post), notice: "Comment was successfully updated."
    else
      render :edit, alert: "Comment was not updated."
    end
  end

  def destroy
    @comment.destroy
    redirect_to @post, notice: "Comment was successfully destroyed."
  end

  private

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
