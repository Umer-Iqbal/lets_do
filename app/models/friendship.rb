class Friendship < ApplicationRecord
  enum status: {pending: 0, accepted: 1, rejected: 2 }

  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'
end
