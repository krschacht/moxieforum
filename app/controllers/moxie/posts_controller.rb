module Moxie
  class PostsController < ApplicationController
    before_filter :require_user, :only => [ :new, :create ]

    layout 'forums'

    unloadable

    def show
      @post = Post.find( params[:id] )

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @post }
      end
    end
  
    def new
      @post = Post.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @post }
      end
    end
    
    def create
      post_params = params[:moxie_post]
      post_params[:author_id] = current_user.id
      
      @post = Post.new( post_params )

      respond_to do |format|
        if @post.save
          format.html { redirect_to( moxie_topic_path( @post.topic ), 
                                :notice => 'Post was successfully created.') }
        else
          format.html { render :action => "new" }
        end
      end
    end
  end    


  private
  
  def require_user
    redirect_to moxie_authorization_error_path
  end

end

