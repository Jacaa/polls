Rails.application.routes.draw do

  root 'home#index'
  
  get   "/cookies",      to: "home#cookies_eu"
  get   "/:id/results",  to: "polls#show",   as: "results"
  get   "/:id/voting",   to: "polls#edit",   as: "voting"
  patch "/:id/voting",   to: "polls#update", as: "update"
  post  "/",             to: "polls#create"
end
