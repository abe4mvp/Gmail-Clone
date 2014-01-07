class ChatsController < ApplicationController
  respond_to :json

  def create
    lincoln_quotes = [
      "Better to remain silent and be thought a fool than to speak out and remove all doubt",
      "4 score and 7 years ago...",
      "Nearly all men can stand adversity, but if you want to test a man's character, give him power.",
      "Give me six hours to chop down a tree and I will spend the first four sharpening the axe.",
      "Am I not destroying my enemies when I make friends of them?",
      "Those who deny freedom to others deserve it not for themselves."         
    ]


    chat = params[:chat_text]

    chat_partial = render_to_string(partial: "chats/chat", locals: {chat: chat})

    Pusher.trigger(params[:chat_to], "new_chat_message", chat_partial)
    
    if params[:chat_to] == "Abe-Lincoln"
      @lincoln = "Abe-Lincoln"
      auto_respond = render_to_string(partial: "chats/chat", locals: {chat: lincoln_quotes.sample})
      sleep(10.seconds)
      Pusher.trigger(params[:chat_to], "new_chat_message", auto_respond)
    end

    if request.xhr?
      head :created
    else
      redirect_to root_url
    end
    
    
  end
end
