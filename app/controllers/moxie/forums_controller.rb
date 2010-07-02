module Moxie
  class ForumsController < ApplicationController

    unloadable

    # GET /forums
    # GET /forums.xml
    def index
      @forums = Forum.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @forums }
      end
    end

    # GET /forums/1
    # GET /forums/1.xml
    def show
      @forum = Forum.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @forum }
      end
    end

    # GET /forums/new
    # GET /forums/new.xml
    def new
      @forum = Forum.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @forum }
      end
    end

    # GET /forums/1/edit
    def edit
      @forum = Forum.find(params[:id])
    end

    # POST /forums
    # POST /forums.xml
    def create
      @forum = Forum.new(params[:moxie_forum])

      respond_to do |format|
        if @forum.save
          format.html { redirect_to(@forum, :notice => 'Forum was successfully created.') }
          format.xml  { render :xml => @forum, :status => :created, :location => @forum }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
        end
      end
    end

    # PUT /forums/1
    # PUT /forums/1.xml
    def update
      @forum = Forum.find(params[:id])

      respond_to do |format|
        if @forum.update_attributes(params[:moxie_forum])
          format.html { redirect_to(@forum, :notice => 'Forum was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
        end
      end
    end

    # DELETE /forums/1
    # DELETE /forums/1.xml
    def destroy
      @forum = Forum.find(params[:id])
      @forum.destroy

      respond_to do |format|
        format.html { redirect_to(users_url) }
        format.xml  { head :ok }
      end
    end

  end
end
