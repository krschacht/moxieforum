module MoxieForum
  class Engine < Rails::Engine

    config.mount_at = '/'  # should end with trailing /
    config.user = :user
    config.forum_entity_name = 'forum'
    config.topic_entity_name = 'discussion'
    config.prompt_for_new_topic_creation = "What's your question?"
    config.post_entity_name = 'post'
    
    
  end
end
