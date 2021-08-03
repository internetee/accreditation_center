# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  before_action :login_request, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  def login_request
    user_request = SignIn.new(username: params[:user][:username], password: params[:user][:password])
    result = user_request.sign_in

    checking_username(result)
  end

  def checking_username(result)
    if result["code"] == 1000
      username = result["data"]["username"]
      user = User.find_by(username: username)

      if user.present?
        sign_in user
      else
        # Here you need to implement a random selection of quizzes
        quiz = Quiz.first

        new_user = User.create!(
          username: username,
          superadmin_role: false,
        )

        new_user.quizzes << quiz

        sign_in new_user
        Rails.logger.info "#{new_user.username} sign in"
      end
   
    else
      Rails.logger.info "Fails to sign in"
      # p "Fails to sign in"
    end
  end
end