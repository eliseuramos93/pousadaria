Rails.application.routes.draw do
  devise_for :inn_owners
  root to: 'home#index'
end
