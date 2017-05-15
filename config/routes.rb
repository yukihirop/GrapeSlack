Rails.application.routes.draw do
  get '/auth/:provider/callback', :to  => 'users#show'
  get 'auth/failure', to: redirect('/')
  root 'users#index'
  resources :summaries, except: :edit
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
