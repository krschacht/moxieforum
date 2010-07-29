module MoxieForum
  class Engine < Rails::Engine

    config.mount_at = '/'
    config.user = :user
    
  end
end
