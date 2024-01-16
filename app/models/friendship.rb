class Friendship < ApplicationRecord
  enum status: {pending: 0, accepted: 1, rejected: 2 }

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  after_create_commit :notify_recipient

  private
  def notify_recipient
    FriendshipNotification.with(item: self).deliver(self.friend)
  end
end
