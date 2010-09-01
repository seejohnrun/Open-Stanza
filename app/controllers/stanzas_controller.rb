class StanzasController < ApplicationController

  before_filter :load_stanza, :only => [:show]
  
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
