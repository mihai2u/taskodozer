Taskodozer::Application.routes.draw do

  resources :tasks

  # base
  root :to => "pages#home"
  get "/about" => "pages#about", :as => "about"

  # authenticatoin
  devise_for :users

  # projects
  resources :projects, :except => [:destroy] do
    resources :discussions
    resources :tasks
    resources :topics do
      match 'comments' => "comments#create", :on => :member, :via => :post
      match 'comments/:comment_id/edit' => "comments#edit", :on => :member, :via => :get, :as => "edit_comment"
      match 'comments/:comment_id/' => "comments#update", :on => :member, :as => "update_comment"
    end
  end
  get "/projects/filter/:filter" => "projects#index", :as => "project_filter"
  # archive projects
  match "/projects/:id/archive" => "projects#archive", :as => "project_archive", :via => :post
  match "/projects/:id/reactivate" => "projects#reactivate", :as => "project_reactivate", :via => :post
  # archive discussions
  match "project/:project_id/discussion/:id/archive" => "discussions#archive", :as => "archive_project_discussion", :via => :post
  match "project/:project_id/discussion/:id/reactivate" => "discussions#reactivate", :as => "reactivate_project_discussion", :via => :post

  # new_project_discussion_topic_path
  match "project/:project_id/discussion/:id/topics/new" => "topics#new", :as => "new_project_discussion_topic", :via => :get

  # companies
  resources :companies, :except => [:index, :show]

  # accesses
  match "/projects/:project_id/accesses/new" => "accesses#new", :via => :get, :as => "new_access"
  match "/accesses" => "accesses#create", :via => :post, :as => "accesses"
  match "/accesses/:project_id" => "accesses#create_self", :via => :post, :as => "accesses_add_self"
  match "/accesses" => "accesses#index", :via => :get, :as => "accesses"
  match "/projects/:project_id/accesses/:user_id" => "accesses#destroy", :as => "access"
  # match "/accesses/:id" => "accesses#destroy", :via => :delete, :as => "access"

  # subscriptions
  match "/topic/:topic_id/subscribe" => "subscriptions#create_topic_self", :via => :post, :as => "topic_subscriptions_add_self"
  match "/topic/:topic_id/unsubscribe/:user_id" => "subscriptions#destroy_topic", :as => "topic_subscriptions"

  # administrative
  get "administration/management"
  get "/manage" => "administration#home", :as => "administration_home"
  # administrative - users
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
