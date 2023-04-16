class PostsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.order("created_at DESC")
    # respond_to do |format|
    #   format.html # Render the index.html.erb template
    #   format.turbo_stream # Render the Turbo Streams template
    # end
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(:posts_count, html: Post.count),
            turbo_stream.prepend('all_posts', partial: 'posts/post', locals: { post: @post })
          ]
        end
      end
    else
      render :new, flash.now[:notice] = "Message n sent"
    end
  end

  def edit
  end

  def update

    if @post.update(post_params)
      head 200
      # redirect_to root_path, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    head 200 if @post.destroy
    # redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def like
    @post = Post.find(params[:id])
    # Add your logic for liking a post here
  end

  private

  def update_jj
    render turbo_stream: turbo_stream.prepend(:posts_count, html: Post.count)
    # Turbo::StreamsChannel.broadcast_update_to :posts_list, target: 'comments_count', partial: 'posts/count', locals: { count: Post.count }
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
