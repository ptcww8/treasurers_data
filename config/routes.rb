Rails.application.routes.draw do
  resources :performances
  devise_for :users
  resources :treasurers
	resources :treasurers do
    match 'advanced_search' => 'treasurers#advanced_search',
          on: :collection, via: [:get, :post], as: :advanced_search
  end
	root to: "treasurers#index"
	get '/treasurers/:id/verify', to: 'treasurers#toggle_verify', as: :verify_treasurer
	get '/treasurers/:id/make_principal_treasurer', to: 'treasurers#make_principal_treasurer', as: :make_principal_treasurer
	get '/treasurers/:council/pull_branches', to: 'treasurers#pull_branches', as: :pull_branches
	get '/performances_query', to: 'performances#query', as: :query_performances
	post '/performances_query', to: 'performances#postquery', as: :query_performances_data
	post '/treasurers/:id/update_comments', to: 'treasurers#update_comments', as: :update_comments
	mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
