Rails.application.routes.draw do
  resources :favorites, only:[:index, :create, :destroy]
  resources :uers, only:[:new, :create, :shouw, :edit]
  resources :session, only:[:new, :create, :destroy]
  resources :picture do
    collection do
      post :confirm
    end
  end 
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
