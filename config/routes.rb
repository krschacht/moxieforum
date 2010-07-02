Rails.application.routes.draw do |map|
  
  namespace :forum do
    resources :accounts, :controller => 'moxie_forum/accounts', :only => [:new, :create]
    resource :session, :controller => 'moxie_forum/sessions', :only => [:new, :create, :destroy]
  end
  
end
