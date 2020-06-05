Rails.application.routes.draw do
  namespace :site do    
    get 'welcome/index'
    get 'search', to: 'search#questions'
    get 'subject/:subject_id/:subject', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
  end
  namespace :admins_backoffice do
    resources :admins, except: [:show]
    resources :subjects, except: [:show]
    resources :questions, except: [:show]
    get 'welcome/index'
  end
  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
    patch 'profile', to: 'profile#update'
  end
  devise_for :admins, skip: [:registration]
  devise_for :users

  get 'backoffice', to: 'admins_backoffice/welcome#index'

  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
