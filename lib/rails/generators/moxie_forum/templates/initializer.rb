module MoxieForum
  class Engine < Rails::Engine

    config.mount_at = '/'  # should end with trailing /
    config.user = :user
    
  end
end
