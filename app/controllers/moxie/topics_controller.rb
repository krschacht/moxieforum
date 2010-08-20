module Moxie
  class TopicsController < ApplicationController
    before_filter :require_user, :only => [ :new, :create ]

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
      topic_params = params[:moxie_topic]
      topic_params[:author_id] = current_user.id
      topic_params[:posts_attributes]['0'][:author_id] = current_user.id
            
      @topic = Topic.new( topic_params )
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
  
  
  private
  
  def require_user
    redirect_to moxie_authorization_error_path
  end

end
