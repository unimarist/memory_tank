Rails.application.routes.draw do
  get 'tanks/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tanks#index"
  get '/tanks/:id', to: 'tanks#new'

    resources :tanks , :except => :show do
      member do
        get 'word_search'
        get 'question_search'
      end
      resources :words do
        collection do
          get 'learned'
          get 'unlearned'
        end
        member do
          get 'correct_count'
          get 'uncorrect_count'
        end
      end
    end

   

end
