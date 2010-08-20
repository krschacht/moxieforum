module Moxie
  class Post < ActiveRecord::Base
    set_table_name "moxie_posts"
    
    begin
      user_model = MoxieForum::Engine.config.user_model_name
    rescue
      user_model = "user"
    end
    
    belongs_to :topic
    belongs_to :author, :class_name => user_model
    
    validates :body, :presence => true
    
    after_create    :increment_topic_post_count
    before_destroy  :decrement_topic_post_count
    
    def increment_topic_post_count
      return  if topic.nil?

      topic.post_count += 1
      topic.save
    end

    def decrement_topic_post_count
      return  if topic.nil?

      topic.post_count -= 1
      topic.save
    end
    
  end
end