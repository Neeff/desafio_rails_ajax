Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    collection do
      get :search
    end
    get 'comment', to: 'posts#new_comment'
    post 'comment', to: 'posts#create_comment'
  end
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
