Rails.application.routes.draw do
  root to: "redirects#new"
  resources :redirects, only: [:new, :create, :index]
end
