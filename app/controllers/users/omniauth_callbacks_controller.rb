class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController


  def slack
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    user = User.find_for_slack_oauth(request.env['omniauth.auth'], current_user)

    if user.persisted?
      session[:user_id] = user.id
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Slack'
      sign_in_and_redirect user, :event => :authentication
    else
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.failure'
      session['devise.slack_data'] = request.env['omniauth.auth']
      redirect_to root_path
    end
  end

  # これがないとルートにリダイレクトしてしまう。
  def after_sign_in_path_for(resource)

    session['devise.slack_data'] || user_path(current_user.id)
  end

end
