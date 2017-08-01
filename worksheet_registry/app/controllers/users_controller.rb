class UsersController < ApplicationController
  def create
    user = User.new(
      user_params.merge(
        token: token(
          user_params[:login],
          user_params[:password]
        )
      )
    )
    if user.valid?
      user.save!
      render json: {
        redirect_url: sign_in_users_url,
        message: 'User created'
      }
    else
      render json: {
        redirect_url: users_url,
        message: error_message(user.errors.messages)
      }
    end
  end

  def sign_in
    user = User.find_by(
      token: token(
        login_params[:login],
        login_params[:password]
      )
    )
    if user
      render json: {
        redirect_url: worksheets_url,
        message: 'Successed'
      }
    else
      render json: {
        redirect_url: sign_in_users_url,
        message: 'User not registered'
      }
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :second_name,
      :login,
      :password
    )
  end
end
