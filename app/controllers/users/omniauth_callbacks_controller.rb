class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def slack
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.find_for_slack_oauth(request.env['omniauth.auth'], current_user)

    if @user.persisted?
      set_flash_message(:notice, :success, :kind => 'Slack') if is_navigational_format?
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.slack_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def passthru

  end


end
