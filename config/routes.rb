Rails.application.routes.draw do
  devise_for :inn_owners, controllers: { registrations: 'registrations' }
  root to: 'home#index'

  resources :inns, only: [:new, :create, :show, :edit, :update] do
    post 'inactive', on: :member
    post 'active', on: :member
  end
  
  get 'my_inn', to: 'inns#my_inn'
end
