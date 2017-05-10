Rails.application.routes.draw do
  resources :contents
  resources :summaries
  resources :slacks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
