class ChatsController < ApplicationController
  respond_to :json

  def create



    chat = params[:chat_text]

    chat_partial = render_to_string(partial: "chats/chat", locals: {chat: chat})

    puts "chat text is nil" if params[:chat_text].nil?
    puts "chat partial is nil" if chat_partial.nil?
    puts "chat to is nil" if params[:chat_to].nil?

    Pusher.trigger(params[:chat_to], "new_chat_message", chat_partial)

    if request.xhr?
      head :created
    else
      redirect_to root_url
    end
  end
end
