ActionController::Routing::Routes.draw do |map|
  map.calendar '/calendar/:year/:month', :controller => 'calendar', :action => 'index', :year => Time.zone.now.year, :month => Time.zone.now.month
  map.resources :seasons
  map.resources :bookings
  map.resources :bookings, :collection => { :sort => :post} 
  map.calculate "calculate", :controller => "bookings", :action=> "calculate"
  map.resources :taggables
  map.resources :tags
  map.resources :houses
  map.resources :pages
  map.resources :discounts

  map.home "home", :controller => "root", :action => "index"
  map.cart "cart", :controller => "houses", :action => "cart"
  map.special_offers "special_offers", :controller => "houses", :action => "index", :discount => true, :q => ''
  map.contact "contact", :controller => "pages", :action => "show", :page => "contact"
  map.programs "programs", :controller => "pages", :action => "show", :page => "programs"
  [:infos_a_z, :map, :weather, :calendar, :sights, :offers, :terms, :impressum, :owners].each do |path|
    map.connect path.to_s, :controller => "pages", :action => "show", :id => path
  end
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.setup "setup", :controller => "setup", :action => "index" 
  
  map.resources :user_sessions

  map.resources :users
  
  map.resources :conditions, :active_scaffold => true

  map.root :controller => "root", :action => "index"
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
