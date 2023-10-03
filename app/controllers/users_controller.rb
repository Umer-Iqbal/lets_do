class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :profile_images_edit]

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts.all
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

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :avatar, :wallpaper)
  end

end
