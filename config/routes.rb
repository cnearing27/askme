Rails.application.routes.draw do
  root to: "questions#index"

  resources :questions
  resource :session, only: %i[new create destroy]
  resources :users, param: :nickname, except: %i[index]

  resources :hashtags, param: :body, only: [:show]

  resources :questions do
    member do
      put :hide
    end

    resources :hashtags, only: [:index]
  end
end
