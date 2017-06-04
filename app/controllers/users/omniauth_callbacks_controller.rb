class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :deny_anonymous

  def slack
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    user = User.find_for_slack_oauth(request.env['omniauth.auth'], current_user)

    if user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Slack'
      sign_in user, :event => :authentication
      redirect_to user_info_path(current_user.nickname)
    else
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.failure'
      session['devise.slack_data'] = request.env['omniauth.auth']
      redirect_to root_path
    end
  end

  def failure
    flash[:notice] = I18n.t 'devise.omniauth_callbacks.failure'
    redirect_to root_path
  end


end
