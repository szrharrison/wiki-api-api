Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :api_wikis, only: [:index]
      resources :pages, only: [:index]

      get '/api_wikis/:slug', to: 'api_wikis#show'
      post '/api_wikis', to: 'api_wikis#create'
      patch '/api_wikis/:slug', to: 'api_wikis#update'
      post '/api_wikis/:slug/pages', to: 'api_wikis#create_page'
      patch '/api_wikis/:slug', to: 'api_wikis#update'
      delete '/api_wikis/:slug', to: 'api_wikis#delete'
      get '/pages/*relative_path/dataset', to: 'datasets#show'
      patch '/pages/*relative_path/dataset', to: 'datasets#update'
      get '/pages/*relative_path', to: 'pages#show'
      post '/pages/*relative_path', to: 'pages#create'
      patch '/pages/*relative_path', to: 'pages#update'
      delete '/pages/*relative_path', to: 'pages#delete'
      post '/auth', to: 'auth#create'
      get '/auth', to: 'auth#show'
      post '/account', to: 'account#create'
      patch '/account', to: 'account#update'
    end
  end

  get '/:slug', to: 'api_wikis#show'
  get '/*relative_path', to: 'pages#show'
end

# get '/*relative_path', to: ...
