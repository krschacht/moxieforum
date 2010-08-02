module Moxie
  class Topic < ActiveRecord::Base
    set_table_name "moxie_topics"

    begin
      user_model = MoxieForum::Engine.config.user_model
    rescue
      user_model = "user"
    end
    
    belongs_to    :forum
    belongs_to    :author,           :class_name => user_model
    belongs_to    :last_post_author, :class_name => user_model
    has_many      :posts

    after_create    :increment_forum_topic_count
    before_destroy  :decrement_forum_topic_count
    after_destroy   :remove_posts
    
    def increment_forum_topic_count
      forum.topic_count += 1
      forum.save
    end

    def decrement_forum_topic_count
      forum.topic_count -= 1
      forum.save      
    end
    
    def remove_posts
      posts.each { |p| p.destroy }
    end
    
  end

end