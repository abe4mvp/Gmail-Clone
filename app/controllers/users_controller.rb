class UsersController < ApplicationController
  

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

   

end
