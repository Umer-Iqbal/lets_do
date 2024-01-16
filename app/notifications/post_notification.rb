# To deliver this notification:
#
# PostNotification.with(post: @post).deliver_later(current_user)
# PostNotification.with(post: @post).deliver(current_user)

class PostNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database, format: :to_database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  def to_database
    {
      type: self.class.name,
      params: params
    }
  end

  # Add required params
  #
  param :post

  # Define helper methods to make rendering easier.
  #
  def post
    t(".post")
  end
  #
  # def url
  #   post_path(params[:post])
  # end
end
