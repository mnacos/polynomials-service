Rails.application.routes.draw do
  get '/differentiate/*coefficients', to: 'differentiation#show'
end
