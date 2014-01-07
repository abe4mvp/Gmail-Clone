class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper

  include MessagesHelper

  include ApplicationHelper

  include ChatsHelper
end
