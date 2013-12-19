module MessagesHelper

  def imply_sender
    params[:message][:sender_id] = current_user.id
    params[:message][:sender] = current_user.email
  end

  def internal_only?
    @message.recipient_emails.split(";").map(&:strip).slice(1..-1).any? do |email|
      !email.ends_with?('@abemail.net')
    end #use a lambda here?
  end

  def create_sender_flags!
    @message.flags.new(user_id: current_user.id)
  end



end
