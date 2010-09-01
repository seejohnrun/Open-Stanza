class AccountsController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_back_or_default user_url(@user)
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end
  
  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    params[:user][:display_name] = nil if params[:user].has_key?(:display_name) && params[:user][:display_name].blank?
    if @user.update_attributes(params[:user])
      redirect_to user_url(@user)
    else
      render :action => :edit
    end
  end
  
end
