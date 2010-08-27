class UsersController < ApplicationController

  before_filter :load_user, :only => [:show]
  
  def show
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
