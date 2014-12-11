Rails.application.routes.draw do

  get 'bad_login' => 'bad_login#login'

  devise_for :users
  root "home#show"
  resources :shows, only: [:index, :show] do
    resources :episodes, only: [:index, :show]
  end
  get "shows/search/:name/"=>"shows#search"
  #get "users/index"=>"users#index"
  get "profiles/add_favorite/:id" => "profiles#add_favorite"
  get "profiles/remove_favorite/:id" => "profiles#remove_favorite"
  get "profiles/get_favorites" => "profiles#get_favorites"

  get "episodes/add_watched/:id" => "episodes#add_watched"
  get "episodes/remove_watched/:id" => "episodes#remove_watched"
  get "episodes/get_watched" => "episodes#get_watched"
  resources :profiles, only: [:index, :show]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
