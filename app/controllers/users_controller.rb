class UsersController < ApplicationController

  before_filter :load_user, :only => [:show]
  
  def show
    @all_stanzas = Stanza.by_user(@user).order('title ASC')
    @all_stanzas = @all_stanzas.public.published unless current_user == @user
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
