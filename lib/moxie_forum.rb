module MoxieForum
  require 'moxie_forum/engine' if defined?(Rails) && Rails::VERSION::MAJOR == 3
  require 'moxie_forum/acts_as_moxie_user/base'
end
