Rails.application.routes.draw do

  root 'home#index'
  
  post "/",            to: "polls#create"
  get "/:id/results",  to: "polls#show",   as: "results"
  get "/:id/voting",   to: "polls#edit",   as: "voting"
  patch "/:id/voting", to: "polls#update", as: "update"

end
