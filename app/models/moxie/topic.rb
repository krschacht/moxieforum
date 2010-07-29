module Moxie
  class Topic < ActiveRecord::Base
    set_table_name "moxie_topics"

    belongs_to :forum
    belongs_to :author,           :class_name => MoxieForum::Engine.config.user_model
    belongs_to :last_post_author, :class_name => MoxieForum::Engine.config.user_model
    has_many :posts
  end

end