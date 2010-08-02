ENV["RAILS_ENV"] = "test"

require 'test/unit'
require 'rubygems'
require 'yaml'
require 'active_record'
require 'mysql'

require 'app/models/moxie/forum.rb'
require 'app/models/moxie/topic.rb'
require 'app/models/moxie/post.rb'

# class Test::Unit::TestCase
# class ActiveSupport::TestCase
#   # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
#   #
#   # Note: You'll currently still have to declare fixtures explicitly in integration tests
#   # -- they do not yet inherit this setting
#   fixtures :all
# 
#   # Add more helper methods to be used by all tests here...
# end

def moxie_forums( fixture_name )
  id = @@fixtures['moxie_forum'][ fixture_name.to_s ][ 'id' ]
  Moxie::Forum.find( id )
end

def moxie_topics( fixture_name )
  id = @@fixtures['moxie_topic'][ fixture_name.to_s ][ 'id' ]
  Moxie::Topic.find( id )
end

def moxie_posts( fixture_name )
  id = @@fixtures['moxie_post'][ fixture_name.to_s ][ 'id' ]
  Moxie::Post.find( id )
end

def load_schema
  config = YAML::load( IO.read( File.dirname(__FILE__) + '/database.yml') )

  ActiveRecord::Base.establish_connection( config['mysql'] )
  ActiveRecord::Base.connection()
  
  load(File.dirname(__FILE__) + "/../" +
    "lib/rails/generators/moxie_forum/templates/schema.rb")

  @@fixtures = {}
  
  load_fixture( 'moxie_forum' )
  load_fixture( 'moxie_topic' )
  load_fixture( 'moxie_post' ) 
end

def load_fixture( table )
  @@fixtures[ table ] = {}
  fixture = YAML::load( IO.read( File.dirname(__FILE__) + "/fixtures/#{table}.yml") )
  @@fixtures[ table ] = fixture

  klass = class_eval table.titleize.gsub(/ /, '::')

  fixture.each do |record_name, record|
    record.each do |column, value|
      if ( match = column.match(/(.*)_id/) )
        fixture_reference = "moxie_" + match[1].pluralize
        if value.is_a? Symbol
          r = class_eval "#{fixture_reference}( '#{value}' )"
          record[ column ] = r.id
        end
      end
    end
      
    r = klass.create( record )
    @@fixtures[ table ][ record_name ][ 'id' ] = r.id
  end

end
