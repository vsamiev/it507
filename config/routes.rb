Rails.application.routes.draw do
  resources :payments
  resources :bookings
  resources :guests
  resources :managers
  resources :rooms
  resources :buildings, path: 'locations'
  root to: 'dashboard#index'
end
