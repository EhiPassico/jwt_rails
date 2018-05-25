class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: [:login_user, :new, :create]

  def new

  end


  def create
    @user = User.new(user_params)
    if @user.save
      response.headers["AUTH-TOKEN"] = get_jwt_token
      # render json: {data: {jwt: get_jwt_token, user: @user}, message: "User Created"}, status: :ok
      render json: {status: 'success', message: "User Created"}
    else
      render json: {status: 'fail', message: "user not created"}, status: :unprocessable_entity
    end
  end


  def login_user
    @user = User.find_by(username: params[:user][:username], password: params[:user][:password])

    if @user
      response.headers["AUTH-TOKEN"] = get_jwt_token
      render json: {status: 'success', message:'user logged in'}
    else
      render json: {status: 'fail', message: 'username/password mismatch'}
    end

  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def get_jwt_token
    User.encode_jwt_token(user_id: @user.id)
  end

end


##################