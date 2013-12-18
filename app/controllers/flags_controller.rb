class FlagsController < ApplicationController
  respond_to :html, :json
  def update # needs to resppond to html also??
    flag = Flag.find(params[:id])


    puts "found flag" if flag
    if flag.update_attributes(params[:flag]) #makes this a cool helper
      respond_to do |format|
        format.html { redirect_to inbox_messages_url }
        format.json { render json: flag}
      end
    else
      puts "something went wrong saving a flag"
      render status: 423
    end
  end
end
