class StanzasController < ApplicationController

  before_filter :load_stanza, :only => [:show]
  before_filter :require_user, :only => [:new, :create]
  
  def new
    @stanza = Stanza.new
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
    @more_by_author = Stanza.published.by_user(@stanza.user)
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
