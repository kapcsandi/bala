ActionController::Routing::Translator.prefix_on_default_locale = true

ActionController::Routing::Routes.draw do |map|
  map.resources :event_logs
  map.house_seasons 'house_seasons', :controller => "seasons", :action => 'house_seasons'
  map.resources :seasons
  map.resources :bookings
  map.resources :houses_bookings
  map.resources :bookings, :collection => { :sort => :post} 
  map.calculate "calculate", :controller => "bookings", :action=> "calculate"
  map.resources :taggables
  map.resources :tags
  map.resources :houses
  map.resources :pages
  map.resources :discounts
  map.resources :contact

  map.cart "cart", :controller => "houses", :action => "cart"
  map.special_offers "special_offers", :controller => "houses", :action => "index", :discount => true, :q => ''
  map.programs  "pages/programs", :controller => "pages", :action => "show", :page => "programs"
  map.infos_a_z "pages/infos_a_z", :controller => "pages", :action => "show", :page => "infos_a_z"
  map.map       "pages/map", :controller => "pages", :action => "show", :page => "map"
  map.weather   "pages/weather", :controller => "pages", :action => "show", :page => "weather"
  map.calendar  "pages/calendar", :controller => "pages", :action => "show", :page => "calendar"
  map.sights    "pages/sights", :controller => "pages", :action => "show", :page => "sights"
  map.offers    "pages/offers", :controller => "pages", :action => "show", :page => "offers"
  map.terms     "pages/terms", :controller => "pages", :action => "show", :page => "terms"
  map.impressum "pages/impressum", :controller => "pages", :action => "show", :page => "impressum"
  map.owners     "pages/owners", :controller => "pages", :action => "show", :page => "owners"
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.setup "setup", :controller => "setup", :action => "index" 
  map.image "image", :controller => "image", :action => "index" 
  
  map.resources :user_sessions

  map.resources :users
  
  map.root :controller => "root", :action => "index"
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
ActionController::Routing::Translator.translate_from_file('config','i18n-routes.yml')
