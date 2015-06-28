Rails.application.routes.draw do
  root to: "redirects#new"
  resources :redirects, only: [:new, :create, :index] do
    member do
      get '/update', to: "redirects#update"
    end
  end
end
