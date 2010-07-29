require "moxie_forum"
require "rails"
require "action_controller"

module MoxieForum
  class Engine < Rails::Engine
    #engine_name :authr
    # getting depracation warning
    
    config.mount_at = "/"
    config.user_model = :user
    
    rake_tasks do
      load File.join(File.dirname(__FILE__), '../rails/railties/tasks.rake')
    end
    
    initializer "moxie_forum.check_config" do |app|

      # convert symbol to an uppercase class name string
      if config.user_model.is_a? Symbol
        config.user_model = config.user_model.to_s[0..0].upcase + config.user_model.to_s[1..9]
      end
                  
    end
    
  end
end


# app_config_file = "#{Rails.root}/config/moxie_forum.yml"
# if File.exists?( app_config_file )
#   open app_config_file do |f|
#     YAML.load( f ).each do |e,c|
#       if e == RAILS_ENV
#         @mount_at = c['mount_at']
#       end
#     end
#   end
# end
