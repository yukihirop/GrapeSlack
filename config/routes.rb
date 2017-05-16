Rails.application.routes.draw do

  devise_for :users, :controllers => {
      :sessions         => 'users/sessions',
      :registrations    => 'users/registrations',
      :passwords        => 'users/passwords',
      :omniauth_callbacks => 'users/omniauth_callbacks'
  }

  # get '/auth/:provider/callback', :to  => 'users#show'
  # get 'auth/failure', to: redirect('/')
  root 'users#index'
  resources :summaries, except: :edit
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
