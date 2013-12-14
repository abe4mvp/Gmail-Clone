class SessionsController < ApplicationController
  before_filter :require_current_user!, :only => [:destroy]

  def create

    validate_extension

    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if user.nil?
      render :json => "Email or password was wrong"
    else
      self.current_user = user
      redirect_to user_url(user)
    end
  end

  def destroy
    logout_current_user!
    redirect_to new_session_url
  end

  def new
  end
end
