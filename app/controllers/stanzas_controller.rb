class StanzasController < ApplicationController

  before_filter :load_stanza, :only => [:show, :edit, :update, :destroy]
  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :convert_blank_params, :only => [:create, :update]
  before_filter :block_private, :only => [:show]
  before_filter :only_author, :only => [:edit, :update, :destroy]
  
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

  def destroy
    @stanza.destroy
    redirect_to user_url(current_user)
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
    help
    @more_by_author = Stanza.published.public.by_user(@stanza.user).most_recent.limit(5).exclude(@stanza)
    @most_discussed_by_author = Stanza.published.public.by_user(@stanza.user).most_comments.limit(5).exclude(@stanza)
  end

  private

  def only_author
    (render_404; return false) unless current_user == @stanza.user
  end
  
  def block_private
    (render_404; return false) unless @stanza.public? || @stanza.user == current_user #TODO move to a before_filter
  end
  
  def load_stanza
    begin
      @stanza = Stanza.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
      return false
    end
  end

  def convert_blank_params
    allow_blanks params[:stanza], :copyright_notice # allow some fields to be blank
  end
  
end
