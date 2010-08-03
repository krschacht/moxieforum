module Moxie
  class TopicsController < ApplicationController

    layout 'forums'

    unloadable

    def show
      @topic = Topic.find( params[:id] )
      @post = Post.new

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @topic }
      end
    end
  
    def new
      @topic = Topic.new
      @topic.posts.build
      @forum = Forum.find( params[:forum_id] )

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @topic }
      end
    end
    
    def create
      @topic = Topic.new( params[:moxie_topic] )
      @forum = Forum.find( params[:moxie_topic][:forum_id] )

      respond_to do |format|
        if @topic.save
          format.html { redirect_to( moxie_forum_path( @topic.forum ), 
                                :notice => 'Topic was successfully created.') }
        else
          format.html { render :new }
        end
      end
    end
  end    
end

