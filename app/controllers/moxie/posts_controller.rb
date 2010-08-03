module Moxie
  class PostsController < ApplicationController

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
      @post = Post.new( params[:moxie_post] )

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
end

