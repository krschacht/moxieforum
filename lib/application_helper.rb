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

end
