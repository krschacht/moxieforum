require 'moxie_forum'
require 'rails'
require 'action_controller'
require 'application_helper'

module MoxieForum
  class Engine < Rails::Engine

    # Defaults
    config.mount_at = "/"
    config.user_model = :user
    config.forum_entity_name = 'forum'
    config.topic_entity_name = 'discussion'
    config.prompt_for_new_topic_creation = "What's your question?"
    config.post_entity_name = 'post'
        
    rake_tasks do
      load File.join(File.dirname(__FILE__), '../rails/railties/tasks.rake')
    end
    
    initializer "moxie_forum.check_config" do |app|

      # load all the models in the app
      Dir.glob(RAILS_ROOT + '/app/models/**/*.rb').each { |file| require file }

      # Figure out which one is the official user class
      config.user_model = ActiveRecord::Base.send(:subclasses).select { |c| c.respond_to? :i_am_moxie_user }.first
      config.user_model_name = config.user_model.to_s
      
      # make sure mount_at ends with trailing slash
      config.mount_at += '/'  unless config.mount_at.last == '/'
    end
    
    initializer "static assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
      
#      ActionController::Base.helpers_path << "#{RAILS_ROOT}/vendor/plugins/moxieforum/app/helpers/moxie"
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
