Rails.application.routes.draw do
  get 'tanks/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tanks#index"

    resources :tanks do
      member do
        get 'word_search'
        get 'question_search'
      end
    end


end
