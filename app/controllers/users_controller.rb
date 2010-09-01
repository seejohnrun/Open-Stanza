class UsersController < ApplicationController

  before_filter :load_user, :only => [:show]
  
  def show
    @most_recent_stanzas = Stanza.by_user(@user).most_recent(10)
    @most_recent_stanzas = @most_recent_stanzas.public.published unless current_user == @user
  end

  private

  def load_user
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
      return false
    end
  end
  
end
