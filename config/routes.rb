Diabeteslikeme::Application.routes.draw do

  resources :challenges


  resources :glucose_data


  resources :statuses

  resources :glucose_data do
    collection do
      post 'import'
    end
  end

  devise_for :users, :controllers => {:registrations => 'registrations'}
  resources :authentications
  resources :statuses
  resources :tasks

  resources :users do
    member do
      get 'glucose_data'
    end
  end

  resource :profile, :controller => :profile do
    member do
      post 'single_update'
    end
  end

  match '/profile/public/:id' => 'profile#public', :as => 'public'
  match '/auth/:provider/callback' => 'authentications#create'
  match '/mailbox' => 'mailbox#index'
  match '/calendar'  => 'calendar#index'
  root :to => "home#index"

end