Trackr::Application.routes.draw do
  
  #get "companies/new"

  resources :companies do
    put :activity, :on => :member
    # put :updateteams, :on => :member
    # put :updatedescription, :on => :member
    put :updatestatus, :on => :member
    resources :contacts, :on => :member do
      get :show_modal, :on => :member
    end
    resources :logs, only: [:create, :destroy, :update, :edit]
    get :autocomplete_user_name, :on => :collection
  end
  resources :users do
    put :editlevel, :on => :member
  end
  
  resources :teams do
    get :autocomplete_user_name, :on => :collection
    put :activity, :on => :member
    resources :companies, :on=> :member, only: [:index]
  end

  resources :contacts do
    put :activity, :on => :member
  end

  resources :logs, only: [:create, :destroy, :update, :edit]

  
  resources :sessions, only: [:new, :create, :destroy]
  root to: 'static#home'

  match '/about',     to: 'static#about'
  match '/contactus', to: 'static#contact'
  match '/signup',    to: 'users#new'
  match '/signin',    to: 'sessions#new'
  match '/signout',   to: 'sessions#destroy', via: :delete
  #match '/contacts',  to: 'contacts#index'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  # 
  match "/500", to:'static#500'
  match "/422", to:'static#422'
  match "/404", to:'static#404'
  

end
