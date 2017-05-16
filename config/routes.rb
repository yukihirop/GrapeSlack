Rails.application.routes.draw do

  devise_for :users, skip: [:registrations, :passwords], :controllers => {
      :sessions         => 'users/sessions',
      :omniauth_callbacks => 'users/omniauth_callbacks',
  }

  # get '/auth/:provider/callback', :to  => 'users#show'
  # get 'auth/failure', to: redirect('/')

  root 'users#index'

  resources :users, only: [:index, :show]
  resources :summaries, except: :edit
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
