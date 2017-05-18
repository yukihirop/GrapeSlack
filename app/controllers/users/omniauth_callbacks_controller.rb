class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def slack
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    user = User.find_for_slack_oauth(request.env['omniauth.auth'], current_user)

    if user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Slack'
      sign_in user, :event => :authentication
      redirect_to user_info_path
    else
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.failure'
      session['devise.slack_data'] = request.env['omniauth.auth']
      redirect_to root_path
    end
  end

end
