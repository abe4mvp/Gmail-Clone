class ChatsController < ApplicationController
  respond_to :json

  def create

    chat = params[:chat_text]
    
    chat_partial = render_to_string(partial: "chats/chat", locals: {chat: chat})
    Pusher.trigger(params[:chat_to], "new_chat_message", chat_partial)
    
    if request.xhr?
      head :created
    else
      fail
      redirect_to root_url
    end
  end
end
