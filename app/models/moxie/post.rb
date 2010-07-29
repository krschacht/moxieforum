module Moxie
  class Post < ActiveRecord::Base
    set_table_name "moxie_posts"
    
    belongs_to :topic
    belongs_to :author, :class_name => MoxieForum::Engine.config.user_model
    
  end
end