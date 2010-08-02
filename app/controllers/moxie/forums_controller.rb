module Moxie
  class ForumsController < ApplicationController

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

  end
end
