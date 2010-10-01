Rails.application.routes.draw do |map|

  mount_at = MoxieForum::Engine.config.mount_at

  match  mount_at => 'moxie/forums#index'

  scope mount_at do
    scope :module => 'moxie', :as => 'moxie' do
      resources :forums, :only => [ :index, :show ] do
        match 'topics/new', :to => 'topics#new', :module => 'moxie', :as => 'new_moxie_topic'
      end
      resources :topics, :only => [ :create, :show ] do
        get :show_postable, :as => 'show_postable_moxie_topic'
      end
      resources :posts

      namespace :admin, :name_prefix => 'admin' do
        resources :forums
      end
    end
  end
  
  match "#{mount_at}/authorization_error" => 'moxie/forums#authorization_error', 
        :as => 'moxie_authorization_error'

end
