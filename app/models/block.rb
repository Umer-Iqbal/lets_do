class Block < ApplicationRecord
  belongs_to :user
  belongs_to :blocked_user, class_name: 'User'

  # You can add any additional logic or validations here.
end