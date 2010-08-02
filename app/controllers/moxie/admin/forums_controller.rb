module Moxie
  class Admin::ForumsController < ApplicationController

    unloadable

    def index
      @forums = Forum.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @forums }
      end
    end

    def show
      @forum = Forum.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @forum }
      end
    end

    def new
      @forum = Forum.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @forum }
      end
    end

    def edit
      @forum = Forum.find(params[:id])
    end

    def create
      @forum = Forum.new(params[:moxie_forum])

      respond_to do |format|
        if @forum.save
          format.html { redirect_to( admin_moxie_forums_path, 
                                :notice => 'Forum was successfully created.') }
        else
          format.html { render :action => "new" }
        end
      end
    end

    def update
      @forum = Forum.find(params[:id])

      respond_to do |format|
        if @forum.update_attributes(params[:moxie_forum])
          format.html { redirect_to( admin_moxie_forums_path, :notice => 'Forum was successfully updated.') }
        else
          format.html { render :action => "edit" }
        end
      end
    end

    def destroy
      @forum = Forum.find(params[:id])
      @forum.destroy

      respond_to do |format|
        format.html { redirect_to( admin_moxie_forums_path ) }
      end
    end
  end
end
