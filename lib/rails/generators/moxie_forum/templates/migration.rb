class CreateMoxieForumTables < ActiveRecord::Migration
  def self.up
    INSERT_SCHEMA
  end

  def self.down
    drop_table :moxie_forums
    drop_table :moxie_topics
    drop_table :moxie_posts
  end
end
