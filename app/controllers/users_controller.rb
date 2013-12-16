class UsersController < ApplicationController
  before_filter :require_current_user!, only: [:show]

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
     render :show
   end
   #change this later when bootstrapping

   def sent
     @messages = current_user.sent
     render :show
   end

   def favorite
     # @message = current_user.favorite
   end

end
