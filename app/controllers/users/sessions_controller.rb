# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    login_request

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
    session[:auth_token] = generate_token(username: params[:user][:username], password: params[:user][:password])
    username = User.find_by(username: params[:user][:username])
    
    if username && username.valid_password?(params[:user][:password]) && username.superadmin_role
      sign_in username
      # generate_quizzes(username) # if uncomment it then quizzez will added for amin user

      initialize_сache_values
    else
      user_request = SignIn.new(username: params[:user][:username], password: params[:user][:password])
      result = user_request.sign_in

      checking_username(result)
    end
  end

  def checking_username(result)
    if result["code"] == 1000
      username = result["data"]["username"]
      email = result["data"]["registrar_email"]
      user = User.find_by(username: username)

      initialize_сache_values

      if user.present?

        generate_quizzes(user)
        sign_in user
      else
        new_user = User.create!(
          username: username,
          email: email,
          superadmin_role: false,
        )

        generate_quizzes(new_user)
        sign_in new_user
        Rails.logger.info "#{new_user.username} sign in"
      end
    else
      Rails.logger.info "Fails to sign in"
    end
  end
  
  private

  def generate_quizzes(user)
    theory = Quiz.where(theory: true, user: user)
    practice = Quiz.where(theory: false, user: user)

    Quiz.create!(title: "Theory 1", user: user, theory: true) if theory.empty?
    Quiz.create!(title: "Practice 1", user: user, theory: false) if practice.empty?
  end

  def generate_token(username: , password:)
    Base64.urlsafe_encode64("#{username}:#{password}")
  end


  def initialize_сache_values
		CacheInitializer.generate_values
	end
end
