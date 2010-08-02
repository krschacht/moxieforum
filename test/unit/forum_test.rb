require 'test_helper'

class ForumTest < Test::Unit::TestCase
  load_schema

  def test_models_are_linked_up
    assert_equal moxie_forums(:announcements).title, "Administrative Announcements", 
                    "Fixtures were not loaded"
    assert_equal moxie_forums(:announcements).topics.length, 2
    assert moxie_forums(:announcements).topics.include? moxie_topics(:welcome)
    assert_equal moxie_topics(:welcome).forum, moxie_forums(:announcements)
    assert moxie_topics(:welcome).posts.include? moxie_posts(:welcome_msg)
    assert moxie_posts(:welcome_msg).topic, moxie_topics(:welcome)
  end

  def test_forums_track_topic_count
    start_count = moxie_forums(:announcements).topics.length
    assert_equal moxie_forums(:announcements).topic_count, start_count

    t = Moxie::Topic.create(  :forum_id   => moxie_forums(:announcements).id,
                              :author_id  => 0,
                              :title      => "Important News" )
  
    assert  moxie_forums(:announcements).topics.include? t
    assert_equal  moxie_forums(:announcements).topics.length, start_count + 1    
    t.destroy
    assert_equal  moxie_forums(:announcements).topics.length, start_count    
  end    

  def test_topics_track_post_count
    start_count = moxie_topics(:welcome).posts.length
    assert_equal moxie_topics(:welcome).post_count, start_count

    p = Moxie::Post.create(   :topic_id   => moxie_topics(:welcome).id,
                              :author_id  => 0,
                              :title      => "I forgot",
                              :body       => "Don't forget to introduce yourself." )
  
    assert  moxie_topics(:welcome).posts.include? p
    assert_equal  moxie_topics(:welcome).posts.length, start_count + 1    
    p.destroy
    assert_equal  moxie_topics(:welcome).posts.length, start_count
  end
  
  def test_topics_and_posts_removed_upon_forum_delete
    f = Moxie::Forum.create(  :title      => "Dummy forum" )
    t1 = Moxie::Topic.create( :forum_id   => f.id,
                              :author_id  => 0,
                              :title      => "Dummy topic 1" )
    t2 = Moxie::Topic.create( :forum_id   => f.id,
                              :author_id  => 0,
                              :title      => "Dummy topic 2" )
    p1 = Moxie::Post.create(  :topic_id   => t1.id,
                              :author_id  => 0,
                              :title      => "Dummy post 1.1",
                              :body       => "body" )
    p2 = Moxie::Post.create(  :topic_id   => t1.id,
                              :author_id  => 0,
                              :title      => "Dummy post 1.2",
                              :body       => "body" )

    assert f.topics.include? t1
    assert t1.posts.include? p1    
    assert ! Moxie::Forum.where(  :id => f.id ).empty?
    assert ! Moxie::Topic.where(  :id => t1.id ).empty?
    assert ! Moxie::Post.where(   :id => p1.id ).empty?
    
    f.destroy

    assert Moxie::Forum.where(  :id => f.id ).empty?
    assert Moxie::Topic.where(  :id => t1.id ).empty?
    assert Moxie::Topic.where(  :id => t2.id ).empty?
    assert Moxie::Post.where(   :id => p1.id ).empty?
    assert Moxie::Post.where(   :id => p2.id ).empty?
  end
  
    
end
