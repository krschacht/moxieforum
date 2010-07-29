Rails.application.routes.draw do |map|

  mount_at = MoxieForum::Engine.config.mount_at

  map.resources :forums, 
                :controller => "moxie/forums", 
                :path_prefix => mount_at,
                :name_prefix => "moxie_"

  map.resources :topics, 
                :controller => "moxie/topics", 
                :path_prefix => mount_at,
                :name_prefix => "moxie_"

  map.resources :posts, 
                :controller => "moxie/posts", 
                :path_prefix => mount_at,
                :name_prefix => "moxie_"
  
end
