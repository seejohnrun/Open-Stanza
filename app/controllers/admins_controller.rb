class AdminsController < ApplicationController

  before_filter :require_admin
  
  def show
    @user_count = User.count
    @most_recent_users = User.find(:all, :limit => 5, :order => 'created_at DESC', :conditions => { :suspended => false })
  end

end
