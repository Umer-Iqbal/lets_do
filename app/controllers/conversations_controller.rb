class ConversationsController < ApplicationController
  def index
    @friends = current_user.friends

    @recipient_id = @friends.first.id
    @messages = Message.where(
      "(recipient_id = :current_user_id AND sender_id = :recipient_id) OR (recipient_id = :recipient_id AND sender_id = :current_user_id)",
      current_user_id: current_user.id,
      recipient_id: @recipient_id
    ).order(created_at: :asc)
  end

  def load_conversation
    recipient_id = params[:recipient_id]
    messages = Message.where(
      "(recipient_id = :current_user_id AND sender_id = :recipient_id) OR (recipient_id = :recipient_id AND sender_id = :current_user_id)",
      current_user_id: current_user.id,
      recipient_id: recipient_id
    ).order(created_at: :asc)

    render turbo_stream: turbo_stream.update('conversation_wrapper', partial: "conversations/conversation_messages", locals: { messages: messages, recipient_id: recipient_id })
  end
end