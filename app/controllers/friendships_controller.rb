class FriendshipsController < ApplicationController
  before_action :set_friend, only: :create

  def create
    friend_request = Friendship.new(user_id: current_user.id, friend_id: params[:friend_id], status: 'pending')
    if friend_request.save
      flash.now[:notice] = "Friend request sent"
      render turbo_stream: turbo_stream.update('flashMessage', partial: 'shares/flash_message')
    end
  end

  def update
    if params[:add_friend] == 'true'
      if Friendship.find(params[:request_id]).update(status: "accepted")
        flash.now[:notice] = "Friend Request Accepted"
      end
    else
      if Friendship.find(params[:request_id]).update(status: "rejected")
        flash.now[:alert] = "Friend Request Rejected"
      end
    end
    render turbo_stream: turbo_stream.update('flashMessage', partial: 'shares/flash_message')
  end

  private
  def set_friend
    @friend_ship = current_user.friendships.find_by(friend_id: params[:friend_id])
    if @friend_ship.present?
      flash.now[:notice] = "Friend request already sent"
      render turbo_stream: turbo_stream.update('flashMessage', partial: 'shares/flash_message')
    end
  end
end
