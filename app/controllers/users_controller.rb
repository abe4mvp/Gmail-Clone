class UsersController < ApplicationController
  before_filter :require_current_user!, only: [:show]

   def create
     @user = User.new(params[:user])

     if @user.save
       self.current_user = @user
       redirect_to user_url(@user)
     else
       render :json => @user.errors.full_messages
     end
   end

   def new
     @user = User.new
   end

   def show
     @sent_messages = current_user.sent_messages
     @received_messages = current_user.received_messages
     @user = current_user
   end
   #change this later when bootstrapping

end
