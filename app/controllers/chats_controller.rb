class ChatsController < ApplicationController
  respond_to :json

  def create



    chat = params[:chat_text]

    chat_partial = render_to_string(partial: "chats/chat", locals: {chat: chat})

    Pusher.trigger(params[:chat_to], "new_chat_message", chat_partial)
    
    if params[:chat_to] == "Abe-Lincoln"
      @lincoln = "Abe-Lincoln"
      auto_respond = render_to_string(partial: "chats/chat", locals: {chat: "4 score and 7 years ago..."})
      Pusher.trigger(params[:chat_to], "new_chat_message", auto_respond)
    end

    if request.xhr?
      head :created
    else
      redirect_to root_url
    end
    
    
  end
end
