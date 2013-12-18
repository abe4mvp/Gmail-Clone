class FlagsController < ApplicationController
  respond_to :json
  def update
    flag = Flag.find(params[:id])


    puts "found flag" if flag
    if flag.update_attributes(params[:flag]) #makes this a cool helper
      render json: flag
    else
      puts "something went wrong saving a flag"
      render status: 423
    end
  end
end
