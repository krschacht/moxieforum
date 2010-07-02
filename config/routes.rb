Rails.application.routes.draw do |map|

  app_config_file = "#{Rails.root}/config/moxie_forum.yml"
  if File.exists?( app_config_file )
    open app_config_file do |f|
      YAML.load( f ).each do |e,c|
        if e == RAILS_ENV
          @mount_at = c['mount_at']
        end
      end
    end
  end
  
  @mount_at ||= '/forum'

  map.resources :forums, 
                :controller => "moxie/forums", 
                :path_prefix => @mount_at, 
                :name_prefix => "moxie_"
  
end
