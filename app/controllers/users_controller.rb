class UsersController < ApplicationController

  before_filter :load_user, :only => [:show]
  
  def show
    # TODO don't show private if user is not SELF
    @most_recent_stanzas = Stanza.published.by_user(@user).most_recent(10)
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
