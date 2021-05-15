Rails.application.routes.draw do
  get 'tanks/index'
  devise_for :users
  root to: "tanks#index"
  get '/tanks/:id', to: 'tanks#new'

    resources :tanks , :except => [:show,:new] do
      member do
        get 'word_search'
        get 'question_search'
        get 'delete_confirm'
      end

      resources :words do
        collection do
          get 'learned'
          get 'unlearned'
          get 'search'
        end
        member do
          get 'correct_count'
          get 'uncorrect_count'
          get 'delete_confirm'
        end
      end

      resources :questions do
        collection do
          get 'learned'
          get 'unlearned'
        end
        member do
          get 'check_a'
          get 'check_b'
          get 'check_c'
          get 'check_d'
          get 'delete_confirm'
        end
      end
    end

  
end
