  end

  def self.down
    drop_table :moxie_forums
    drop_table :moxie_topics
    drop_table :moxie_posts
  end
end
