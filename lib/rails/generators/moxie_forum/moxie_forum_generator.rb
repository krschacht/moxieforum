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
    f = File.open File.join(File.dirname(__FILE__), 'templates', 'schema.rb')
    schema = f.read; f.close
    
    schema.gsub!(/ActiveRecord::Schema.*\n/, '')
    schema.gsub!(/^end\n*$/, '')

    f = File.open File.join(File.dirname(__FILE__), 'templates', 'migration.rb')
    migration = f.read; f.close
    migration.gsub!(/INSERT_SCHEMA/, schema)
    
    tmp = File.open "tmp/~migration_ready.rb", "w"
    tmp.write migration
    tmp.close

    migration_template  '../../../tmp/~migration_ready.rb',
                        'db/migrate/create_moxie_forum_tables.rb'
    remove_file 'tmp/~migration_ready.rb'
  end

  def copy_initializer_file
    copy_file 'initializer.rb', 'config/initializers/moxie_forum.rb'
  end
  
  def initialize_user_model
    begin
      print "    \e[1m\e[34mquestion\e[0m  What's the name of your user model? [user.rb] > "
      model_name = gets.chomp
      model_name = "user.rb"  if model_name.empty?
    end while not model_name =~ /\.rb/i

    begin
      print "    \e[1m\e[34mquestion\e[0m  Would you to auto-add a few necessary lines to the top of #{model_name} [y/n] "
      answer = gets.chomp
    end while not answer =~ /[yn]/i
    
    if answer =~ /y/i
      begin
        f = File.open "app/models/#{model_name}"
        file = f.read; f.close

        # Create the initializer file
        file.gsub!(/class User < ActiveRecord::Base\n/, 
                  "class User < ActiveRecord::Base\n\n" +
                  "\tacts_as_moxie_user\n\n" +
                  "\t# MoxieForum looks for the following optional methods within this class.\n" +
                  "\t#\n" +
                  "\t# def moderator?\n" +
                  "\t# def admin?\n" +
                  "\t# def display_name\n" +
                  "\t# def profile_pic" )

        tmp = File.open "tmp/~model.rb", "w"
        tmp.write file; tmp.close

        remove_file "app/models/#{model_name}"
        copy_file '../../../tmp/~model.rb', "app/models/#{model_name}"
        remove_file 'tmp/~model.rb'
      rescue
        puts "       \e[1m\e[31merror\e[0m  Unable to open #{model_name}, visit ##### for instructions to manually connect your user model"
      end
    else
      puts "    \e[1m\e[33mskipping\e[0m  Visit ##### for instructions to connect your user model"
    end    
    
  end

  def update_application_template
    f = File.open "app/views/layouts/application.html.erb"
    layout = f.read; f.close
    
    if layout =~ /<%=[ ]+yield[ ]+%>/
      print "    \e[1m\e[34mquestion\e[0m  Your layouts/application.html.erb layout currently has the " +
            "line <%= yield %>. MoxieForum needs to change this line to <%= content_for?(:content) ? " +
            "yield(:content) : yield %> to support its nested layouts. This change should not affect " +
            "any of your existing layouts or views. "
      begin
        print "Is this okay? [y/n] "
        answer = gets.chomp
      end while not answer =~ /[yn]/i
      
      if answer =~ /y/i
        
        layout.gsub!(/<%=[ ]+yield[ ]+%>/, '<%= content_for?(:content) ? yield(:content) : yield %>')

        tmp = File.open "tmp/~application.html.erb", "w"
        tmp.write layout; tmp.close

        remove_file 'app/views/layouts/application.html.erb'
        copy_file '../../../tmp/~application.html.erb', 
                  'app/views/layouts/application.html.erb'
        remove_file 'tmp/~application.html.erb'
      end
    elsif layout =~ /<%=[ ]+content_for\?\(:content\) \? yield\(:content\) : yield[ ]+%>/
      puts "    \e[1m\e[33mskipping\e[0m  layouts/application.html.erb modification is already done."
    else
      puts  "    \e[1m\e[31mconflict\e[0m  MoxieForum is confused by your " +
            "layouts/application.html.erb. It does not contain the default line <%= yield %>, you " +
            "may need to make manual changes to get MoxieForum's nested layouts working. Visit " +
            "###### for details."
    end
  end
  
  def done
    puts "\n        \e[1m\e[32mdone\e[0m  Installation complete! Run rake db:migrate and start up your web server. You can try the forum at http://localhost:3000/forum but full functionality requires you to have a current_user application method. In addition, open your user model rb file for a few comments near the top.\n\n"
  end
  
end
