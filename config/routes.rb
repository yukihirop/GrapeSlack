Rails.application.routes.draw do

  devise_for :users, skip: [:registrations, :passwords], :controllers => {
      :sessions         => 'users/sessions',
      :omniauth_callbacks => 'users/omniauth_callbacks',
  }

  root 'users#index'
  get '/user/info', to: 'users#show'

  scope :user do
    resources :summaries, except: :edit
  end

  get '*anything' => 'application#routing_error'

end
