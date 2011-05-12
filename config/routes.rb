Taskodozer::Application.routes.draw do
  resources :projects, :except => [:destroy]
  get "/projects/filter/:filter" => "projects#index", :as => "project_filter"
  match "/projects/:id/archive" => "projects#archive", :as => "project_archive", :via => :post
  match "/projects/:id/reactivate" => "projects#reactivate", :as => "project_reactivate", :via => :post
  resources :companies, :except => [:index, :show]

  get "administration/management"

  devise_for :users

  root :to => "pages#home"
  get "/about" => "pages#about", :as => "about"
  get "/manage" => "administration#home", :as => "administration_home"
  get "/manage/users" => "administration#users", :as => "administration_users"
  get "/manage/users/:id" => "administration#user_edit", :as => "administration_user_edit"
  get "/manage/companies/:id/add" => "administration#user_new", :as => "administration_user_new"
  match "manage/companies/add" => "administration#user_create", :as => "administration_user_create"
  match "/manage/users/:id" => "administration#user_update", :as => "administration_user_update"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
