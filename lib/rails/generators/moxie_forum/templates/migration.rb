class CreateMoxieForumTables < ActiveRecord::Migration
  def self.up
    INSERT_SCHEMA
    
    # Seed with some initial data
    
    f = Moxie::Forum.create( :title => "Sample forum", :description => "Description of this forum" )
    t1 = Moxie::Topic.create( :forum => f, :title => "First topic" )
    t2 = Moxie::Topic.create( :forum => f, :title => "Second topic" )
    Moxie::Post.create( :topic => t1, :body => "First post in the first topic" )
    Moxie::Post.create( :topic => t1, :body => "Second post in the first topic" )
    Moxie::Post.create( :topic => t2, :body => "First post in the second topic" )
  end

  def self.down
    drop_table :moxie_forums
    drop_table :moxie_topics
    drop_table :moxie_posts
  end
end
