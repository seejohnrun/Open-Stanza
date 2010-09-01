class StanzasController < ApplicationController

  before_filter :load_stanza, :only => [:show, :edit, :update]
  before_filter :require_user, :only => [:new, :create, :edit, :update]
  
  def new
    @stanza = Stanza.new
  end

  def edit
  end

  def update
    if @stanza.update_attributes(params[:stanza])
      redirect_to stanza_url(@stanza)
    else
      render :action => :edit
    end
  end
  
  def create
    @stanza = Stanza.new(params[:stanza]) do |stanza|
      stanza.user = current_user
      stanza.published_at = Time.zone.now
    end
    # save it!
    if @stanza.save
      redirect_to stanza_url(@stanza)
    else
      render :action => :new
    end
  end
  
  def show
    (render_404; return false) unless @stanza.public? || @stanza.user == current_user #TODO move to a before_filter
    
    @more_by_author = Stanza.published.by_user(@stanza.user).most_recent(10)
    @more_by_author = @more_by_author.public unless @stanza.user == current_user
  end

  private

  def load_stanza
    begin
      @stanza = Stanza.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
      return false
    end
  end
  
end
