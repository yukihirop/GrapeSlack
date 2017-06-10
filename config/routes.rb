Rails.application.routes.draw do

  root 'users#index'

  devise_for :users, skip: [:registrations, :passwords], :controllers => {
      :sessions         => 'users/sessions',
      :omniauth_callbacks => 'users/omniauth_callbacks',
  }
  get '/users/auth/failure', to: 'users#index'

  #[参考]https://stackoverflow.com/questions/22887765/rails-route-only-if-resource-is-present
  constraints(lambda {|req| User.exists?(nickname:req.params[:nickname])}) do
    scope '(:nickname)' do
      resources :summaries, except: :edit do
        resources :contents, only: [:new,:create,:destroy]
      end

      get '', to: 'users#show',           as: :user_info
      get '/profile', to: 'users#profile',as: :user_profile

      get '/contents', to: 'contents#index'
      delete '/contents/:id', to: 'contents#destroy'
    end
  end

  get '*anything' => 'application#routing_error'

end
