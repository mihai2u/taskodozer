class AdministrationController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_admin
  
  def home
  end

  def users
    @companies = Company.all
  end

  def user_new
    @company = Company.find(params[:id])
    @user = User.new
    @user.company = @company
    @user.role = "client"
  end

  def user_create
    @user = User.new(params[:user])
    if @user.save
      redirect_to administration_users_path, :notice => "Successfully added user."
    else
      render :action => 'user_new'
    end
  end

  def user_edit
    @user = User.find(params[:id])
  end

  def user_update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = ("The user has been succesfully updated.")
      redirect_to administration_users_path
    else
      render :user_edit
    end
  end

private
  def check_admin
    unless current_user && current_user.admin?
      flash[:notice] = ("Only admins can do management tasks.")
      redirect_to root_path
      return false
    end
  end

end
