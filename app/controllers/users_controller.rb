class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :profile_images_edit, :notifications]
  # skip_before_action :set_user, only: [:add_friend,]
  def index
    @users = User.all
  end

  def show
    @method_name = "users_show"
    @posts = @user.posts.all
    @pagy, @posts = pagy(@posts, items: 10)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def profile_images_edit
    render turbo_stream: turbo_stream.append('middleModal', partial: 'users/profile_images_form', locals: { user: @user })
  end

  def search_user
    if(params[:query].present?)
      users = User.all.where("username LIKE ?", "%#{params[:query]}%")
      render turbo_stream: turbo_stream.update('resource_list_in_component', partial: 'shares/search_user', locals: {items: users })
    else
      render turbo_stream: turbo_stream.update('resource_list_in_component', partial: 'shares/search_user', locals: {items: nil })
    end
  end

  def add_friend
    friend = User.find(params[:friend_user_id])
    if friend.present?
    else

    end
  end

  def notifications
    # friendships = Friendship.where(status: "pending", friend_id: @user.id)
    # render turbo_stream: turbo_stream.update("user_notification", partial: "shares/notification_dropdown", locals: { items: friendships.present? ? friendships : nil})

    notifications = current_user.notifications.order(created_at: :desc)
    render turbo_stream: turbo_stream.update("user_notification", partial: "shares/notification_dropdown", locals: { notifications: notifications})
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar, :wallpaper)
  end

end
