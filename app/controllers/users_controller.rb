class UsersController < ApplicationController
  before_filter :require_current_user!, only: [:show]
  respond_to

   def create
     validate_extension

     @user = User.new(params[:user])

     if @user.save
       self.current_user = @user
       redirect_to inbox_user_url(@user)
     else
       render :json => @user.errors.full_messages
     end
   end

   def inbox
     @messages = current_user.inbox

     respond_to do |format|
       format.html render :show
       format.json respond_with(@messages)
     end

   end
   #change this later when bootstrapping

   def sent
     @messages = current_user.sent

     if request.xhr?
       render partial: 'email_box', locals: {messages: @messages}
     else
       render :show
     end
   end

   def favorite
     # @message = current_user.favorite
   end

end
