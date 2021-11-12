Rails.application.routes.draw do
  ## For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #get '/articles' to: 'articles#index'
  
    #resources :articles, only: [:index]
    #resources :articles, only: %i[index show]
    resources :articles
    
  #resources ja gera a rota pra CRUD
end
