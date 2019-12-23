Rails.application.routes.draw do
  devise_for :users
  resources :treasurers
	root to: "treasurers#index"
	get '/treasurers/:id/verify', to: 'treasurers#toggle_verify', as: :verify_treasurer
	get '/treasurers/:id/make_principal_treasurer', to: 'treasurers#make_principal_treasurer', as: :make_principal_treasurer
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
