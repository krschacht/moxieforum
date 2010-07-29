class CreateMoxieForumTables < ActiveRecord::Migration
  def self.up
    
    create_table :moxie_forums, :force => true do |t|
      t.string    :title
      t.text      :description
      t.integer   :position,       :default => 1
      t.integer   :topics_count,   :default => 0
	    t.datetime  :created_at
	    t.datetime  :updated_at
    end

    create_table :moxie_topics, :force => true do |t|
      t.integer   :forum_id
      t.integer   :author_id
      t.string    :title
      t.integer   :post_count,          :default => 0
      t.integer   :views,               :default => 0
      t.boolean   :locked,              :default => false
      t.boolean   :sticky,              :default => false
      t.integer   :last_post_author_id
      t.datetime  :last_post_at
	    t.datetime  :created_at
	    t.datetime  :updated_at
    end

    add_index :moxie_topics, [:author_id], :name => "topics_author_id"
    add_index :moxie_topics, [:created_at], :name => "topics_created_at"
    add_index :moxie_topics, [:forum_id], :name => "topics_forum_id"
    add_index :moxie_topics, [:last_post_at], :name => "topics_last_post_at"

    create_table :moxie_posts, :force => true do |t|
      t.integer   :topic_id
      t.integer   :author_id
      t.string    :title
      t.text      :body
      t.string    :browser
	    t.datetime  :created_at
	    t.datetime  :updated_at
    end

    add_index :moxie_posts, [:author_id], :name => "posts_author_id"
    add_index :moxie_posts, [:created_at], :name => "posts_created_at"
  end

  def self.down
    drop_table :moxie_forums
    drop_table :moxie_topics
    drop_table :moxie_posts
  end
end
