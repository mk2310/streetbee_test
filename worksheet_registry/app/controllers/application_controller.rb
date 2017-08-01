class ApplicationController < ActionController::API
  def login_before_action
    User.find_by(
      token: token(
        login_params[:login],
        login_params[:password]
      )
    ).nil? ? redirect_to_login : true
  end

  def token(login, password)
    JWT.encode({ login: login, password: password }, nil, 'none')
  end

  private

  def error_message(hsh)
    hsh.map { |key, value| [key.to_s, value.join(', ')].join(': ') }.join(', ')
  end

  def redirect_to_login
    render json: { redirect_url: sign_in_users_url }
  end

  def login_params
    params.require(:login).permit(
      :login,
      :password
    )
  end
end
