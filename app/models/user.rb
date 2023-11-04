class User < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :wallpaper
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships, source: :friend
  has_many :blocks, dependent: :destroy
  has_many :blocked_users, through: :blocks

  validates :email, presence: true, uniqueness: true

  has_many :conversation, as: :conversationable
  has_many :messages, through: :conversation
end
