class ChatsController < ApplicationController
  respond_to :json
  after_filter :auto_respond

  def create
    
    chat = params[:chat_text]

    chat_partial = render_to_string(partial: "chats/chat", locals: {chat: chat})
    
    @name = current_user.name.gsub(' ', '-')

    Pusher.trigger(params[:chat_to], "new_chat_message", chat_partial)
    
    
    

    if params[:chat_to] == "Abe-Lincoln"
      head :accepted
    else
      head :created
    end

    
  end
  
end
