Rails.application.routes.draw do

  root 'users#index'

  devise_for :users, skip: [:registrations, :passwords], :controllers => {
      :sessions         => 'users/sessions',
      :omniauth_callbacks => 'users/omniauth_callbacks',
  }
  get '/users/auth/failure', to: 'users#index'

  scope '(:nickname)' do
    get '', to: 'users#show',           as: :user_info
    get '/profile', to: 'users#profile',as: :user_profile
  end

  scope '(:nickname)' do
    resources :summaries, except: :edit do
      resources :contents, only: [:new,:create,:destroy]
    end

    get '/contents', to: 'contents#index'
    delete '/contents/:id', to: 'contents#destroy'

  end

  get '*anything' => 'application#routing_error'

end
