class CommentsController < ApplicationController

  before_filter :require_user, :only => [:create]
  before_filter :load_stanza, :only => [:create]
  before_filter :ensure_stanza_is_public, :only => [:create]
  
  def create
    @comment = @stanza.comments.new(params[:comment]) do |comment|
      comment.user = current_user
    end
    if @comment.save
      redirect_to stanza_url(@stanza)
    else
      # TODO handle negative case gracefully
      redirect_to stanza_url(@stanza)
    end
  end

  private

  def ensure_stanza_is_public
    (render_404; return false) unless @stanza.public || @stanza.user == current_user
  end
  
  def load_stanza
    begin
      @stanza = Stanza.find(params[:stanza_id])
    rescue ActiveRecord::RecordNotFound
      render_404
      return false
    end
  end
  
end
