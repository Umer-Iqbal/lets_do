class PostsController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @method_name = "posts_index"
    @posts = Post.all.order("created_at DESC")
    @pagy, @posts = pagy(@posts, items: 10)
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
      flash.now[:notice] = "Post created successfully"
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend('all_posts', partial: 'shares/post', locals: { post: @post }),
            turbo_stream.update('flashMessage', partial: 'shares/flash_message', locals: { message: 'Resource created successfully' })

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
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: [turbo_stream.replace('flashMessage', partial: 'shares/flash_message', locals: { message: 'Resource created successfully' }),
                                                    turbo_stream.replace("post_#{@post.id}", partial: 'shares/post', locals: { post: @post })] }
      end
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
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
