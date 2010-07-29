require 'rails/generators'
require 'rails/generators/migration'

class MoxieForumGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    File.join(File.dirname(__FILE__), 'templates')
  end

   # Implement the required interface for Rails::Generators::Migration.
   # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
   # examples: http://caffeinedd.com/guides/331-making-generators-for-rails-3-with-thor
   
  def self.next_migration_number(dirname) #:nodoc:
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def create_migration_file
    migration_template 'migration.rb', 'db/migrate/create_moxie_forum_tables.rb'
  end
  
  # def copy_config_file
  #   copy_file 'config.yml', 'config/moxie_forum.yml'
  # end

  def copy_initializer_file
    copy_file 'initializer.rb', 'config/initializers/moxie_forum.rb'
  end
end
