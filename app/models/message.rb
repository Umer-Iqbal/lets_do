class Message < ApplicationRecord
  has_rich_text :body

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
end
