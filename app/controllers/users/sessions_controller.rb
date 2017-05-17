class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :require_no_authentication, :only => [ :new, :create, :destroy]

  # GET /resource/sign_in
  def new
    if current_user
      flash[:notice] = I18n.t 'devise.sessions.signed_in'
      redirect_to user_path(id:current_user.id)
    else
      redirect_to user_slack_omniauth_authorize_path
    end
  end

  # POST /resource/sign_in
  def create
  end

  # DELETE /resource/sign_out
  def destroy
    flash[:notice] = I18n.t 'devise.sessions.signed_out'
    current_user = nil
    redirect_to root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
