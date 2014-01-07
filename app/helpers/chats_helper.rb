module ChatsHelper
  
  LINCOLN_QUOTES = [
    "Better to remain silent and be thought a fool than to speak out and remove all doubt",
    "4 score and 7 years ago...",
    "Nearly all men can stand adversity, but if you want to test a man's character, give him power.",
    "Give me six hours to chop down a tree and I will spend the first four sharpening the axe.",
    "Am I not destroying my enemies when I make friends of them?",
    "Those who deny freedom to others deserve it not for themselves."         
  ]
  
  def auto_respond
      @lincoln = "Abe-Lincoln"
      quote = render_to_string(partial: "chats/chat", locals: {chat: LINCOLN_QUOTES.sample})
      sleep(2.seconds)
      Pusher.trigger(params[:chat_to], "new_chat_message", quote)
  end
  
  
end
