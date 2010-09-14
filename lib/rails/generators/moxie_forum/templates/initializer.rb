module MoxieForum
  class Engine < Rails::Engine

    config.mount_at = '/forum'
    config.user_model = :user
    config.forum_entity_name = 'forum'
    config.topic_entity_name = 'discussion'
    config.prompt_for_new_topic_creation = "What's your question?"
    config.post_entity_name = 'post'
    
    # need a link to the login page for messages that direct the user there
    # need a link to the user's profile page so names are clickable
    
  end
end
