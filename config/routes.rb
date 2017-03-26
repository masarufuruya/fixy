Rails.application.routes.draw do
  devise_for :users
  root to: "today_habits#index"
  resources :habits do
    resources :achivements, only: [:update] do
      resource :memo, only: [:show]
      resources :memos, only: [:index, :create, :update]
    end
    resources :memos, only: [:index]
  end
  resources :today_habits, only: [:index]
end
