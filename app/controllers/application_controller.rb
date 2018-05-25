require_relative '../../lib/user_authentication'
class ApplicationController < ActionController::Base
  include UserAuthentication
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #
  protect_from_forgery with: :exception, unless: -> {request.format.json?}

  before_action :authenticate_user


end
