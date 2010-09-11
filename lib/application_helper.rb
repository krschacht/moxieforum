module ApplicationHelper
  
  def moxie_forum_name
    MoxieForum::Engine.config.forum_entity_name
  end

  def moxie_topic_name
    MoxieForum::Engine.config.topic_entity_name
  end

  def moxie_post_name
    MoxieForum::Engine.config.post_entity_name
  end
  
  def current_user
    if  defined?( MoxieForum::Engine.config.user_model ) == 'constant' && 
        MoxieForum::Engine.config.user_model.class == Class
      MoxieForum::Engine.config.user_model.create
    else
      nil
    end
  end

end
