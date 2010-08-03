Rails.application.routes.draw do |map|

  mount_at = MoxieForum::Engine.config.mount_at

  map.resources :forums, :only => [ :index, :show ], 
                :controller   => "moxie/forums", 
                :path_prefix  => mount_at,
                :name_prefix  => "moxie_"
                
  match "#{mount_at}forums/:forum_id/topics/new" => 'moxie/topics#new', :as => 'new_moxie_topic'

  map.resources :topics, :only => [ :show, :create ],
                :controller   => "moxie/topics", 
                :path_prefix  => mount_at,
                :name_prefix  => "moxie_"

  map.resources :posts,
                :controller   => "moxie/posts", 
                :path_prefix  => mount_at,
                :name_prefix  => "moxie_"

  match "#{mount_at}admin" => 'moxie/admin#index', :as => 'moxie_admin'
  
  map.resources :forums,
                :controller   => "moxie/admin/forums",
                :path_prefix  => mount_at + "admin",
                :name_prefix  => "admin_moxie_"
  
end
