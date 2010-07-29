Rails.application.routes.draw do |map|

  mount_at = MoxieForum::Engine.config.mount_at

  map.resources :forums, 
                :controller => "moxie/forums", 
                :path_prefix => mount_at,
                :name_prefix => "moxie_"
  
end
