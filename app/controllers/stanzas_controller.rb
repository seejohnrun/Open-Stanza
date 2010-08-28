class StanzasController < ApplicationController

  before_filter :load_stanza, :only => [:show]
  
  def show
    @more_by_author = Stanza.public.published.by_user(@stanza.user)
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
