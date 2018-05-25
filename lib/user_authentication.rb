module UserAuthentication
  def authenticate_user
    unless allow_user?
      render json: {message: @message || "Not Authorized", status: 'fail'}, status: :unauthorized
    end
  end

  # get authentication token
  # check valid jwt token
  # check user_id presetn it jwt
  # check userid and key matches database
  #

  def allow_user?

    # check whether api request or html request (check for api request in headers)
    if api_request?
      get_jwt_token_from_headers
      if valid_jwt_token?
        get_userid_from_decoded_token
        if userid_exists_in_decoded_token
          if user_exists_in_database
            set_response_headers_with_the_token
            return true #user has access
          end
        end
      end
      # html request authentication handle in else code
    else
      #   do html validation here. checks sessions
    end

  end

  private
  def get_jwt_token_from_headers
    # debugger
    @jwt_token = request.headers["AUTH-TOKEN"]
  end

  def set_response_headers_with_the_token
    response.headers["AUTH-TOKEN"] = @jwt_token
  end


  def user_exists_in_database
    @user = User.find_by(id: @user_id)
    @message = "Not Valid User" unless @user
    return @user
  end

  def userid_exists_in_decoded_token
    @user_id
  end

  def get_userid_from_decoded_token
    @user = nil
    @user_id = @decoded_jwt_token[0]["data"]["user_id"]
  end

  def valid_jwt_token?
    result = false
    begin
      @decoded_jwt_token = User.decode_jwt_token(@jwt_token)
      result = true
    rescue JWT::VerificationError
      @message = "Not Authorized Token"
      result = false
    end
    result
  end

  def api_request?
    @auth_token = request.headers["AUTH-TOKEN"]
  end
end