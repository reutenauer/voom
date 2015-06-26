Rails.application.routes.draw do
  get '/', to: "urls#new"
  post '/', to: "urls#create"
end
