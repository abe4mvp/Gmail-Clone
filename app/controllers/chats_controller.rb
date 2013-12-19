class ChatsController < ApplicationController

  def create
    chat = params[:chat_text]
    chat_partial = render_to_string(partial: "chats/chat", locals: {chat: chat})
    Pusher.trigger("Abe", "new_chat_message", chat_partial)
    if request.xhr?
      head :created
    else
      redirect_to root_url
    end
  end
end
