Rails.application.routes.draw do

  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :doctors
  devise_for :personnels

  namespace :api, defaults: { format: :json}, costraints: { subdomain: 'api' }, path: '/' do

    scope module: :v1 do
      resources :doctors, :only => [:show, :create, :update, :destroy] do
        # post 'doctors' => 'devise/registrations#update', as => 'doctor_update'

        resources :tasks, :only => [:create,:update, :destroy]

        # resources :personnels, :only => [:create, :update, :destroy]
      end

      resources :personnels, :only => [:show, :create, :update, :destroy] do
        resources :tasks, :only => [:update]
      end

      resources :sessions, :only => [:create, :destroy]
      resources :tasks, :only => [:create, :show, :index]

      resources :patients, :only => [:create, :show]

      get 'list/tasks', to: 'tasks#list'
      get 'list/patients', to: 'patients#list'

      put 'tasks', to: 'tasks#update'

      get 'profile/get', to: 'profile#show'
      # get 'profile/edit', to: 'profile#edit'
      put 'profile/edit', to: 'profile#submit'
    end

  end

  get 'sign_in', to: 'sessions#show'
  post 'session_create', to: 'sessions#create'

  get 'dashboard', to: 'dashboard#show'

  #sections routes for nav-sidebar
  get 'tasks_section', to: 'dashboard#tasks_section'
  post 'tasks_section', to: 'dashboard#tasks_section_partial'
  get 'personnel_section', to: 'dashboard#personnel_section'
  get 'patients_section', to: 'dashboard#patients_section'
  get 'wards_section', to: 'dashboard#wards_section'
  get 'exit', to: 'dashboard#exit'

  get 'sign_up', to: 'doctors#sign_up'
  post 'sign_up', to: 'doctors#create'

  get 'create_task', to: 'tasks#create'
  post 'create_task', to: 'tasks#submit'

  get 'show_task', to: 'tasks#show_task'
  get 'edit_task', to: 'tasks#edit_task'
  post 'edit_task', to: 'tasks#edit'
  
  get 'profile', to: 'profile#show'
  get 'edit', to: 'profile#edit'
  post 'profile/edit', to: 'profile#submit'
  
  get 'create_personnel', to: 'personnel#create'
  post 'create_personnel', to: 'personnel#submit'
  get 'show_personnel', to: 'personnel#show_personnel'
  
  get 'create_patient', to: 'patients#create'
  post 'create_patient', to: 'patients#submit'
  get 'show_patient', to: 'patients#show_patient'
  
  get 'create_ward', to: 'wards#create'
  post 'create_ward', to: 'wards#submit'
  get 'show_ward', to: 'wards#show_ward'
  get 'add_patient', to: 'wards#add_patient'
  post 'add_patient/confirm', to: 'wards#confirm'

  root 'dashboard#tasks_section'
  

end
