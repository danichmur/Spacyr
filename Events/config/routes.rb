Rails.application.routes.draw do
  resources :events do
    get :search, on: :collection
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'events#index'
end
