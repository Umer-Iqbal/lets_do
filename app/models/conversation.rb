class Conversation < ApplicationRecord
  belongs_to :conversationable, polymorphic: true
  has_many :messages
end