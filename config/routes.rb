Rails.application.routes.draw do
  #TODO: Antreでは認証は自作にしたい
  #Deviseのコントローラーをカスタマイズ
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }
  root to: "today_habits#index"
  resources :habits do
    resources :achivements, only: [:update] do
      resource :memo, only: [:show]
      resources :memos, only: [:create, :update]
    end
    resources :memos, only: [:index]
  end
  resources :today_habits, only: [:index]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end
end
