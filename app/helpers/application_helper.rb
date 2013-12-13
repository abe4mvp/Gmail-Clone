module ApplicationHelper


  def save_model!(model, options = {redirect_url: nil} )

      if model.save # change to snake case
        redirect_to  options[:redirect_url] || model
      else
        render json: model.errors.full_messages
      end
    end


  def abemail_extension?(email_adress)
    email_address.ends_with?("@abemail.net")
  end

    #send("#{model.class.to_s.downcase}_url", model )
end
