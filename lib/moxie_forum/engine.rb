require "moxie_forum"
require "rails"
require "action_controller"

module MoxieForum
  class Engine < Rails::Engine
    #engine_name :authr
    # getting depracation warning
    
    rake_tasks do
      load File.join(File.dirname(__FILE__), '../rails/railties/tasks.rake')
    end
    
  end
end
