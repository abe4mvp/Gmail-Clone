class ChatsController < ApplicationController
  respond_to :json

  def create
    
    chat = params[:chat_text]

    chat_partial = render_to_string(partial: "chats/chat", locals: {chat: chat})

    Pusher.trigger(params[:chat_to], "new_chat_message", chat_partial)
    
    head :created
    

    if params[:chat_to] == "Abe-Lincoln"
      auto_respond
      head :ok
    end

    
  end
  
end
