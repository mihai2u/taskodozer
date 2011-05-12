class CompaniesController < ApplicationController

  before_filter :check_access

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(params[:company])
    if @company.save
      redirect_to administration_users_path, :notice => "Successfully created company."
    else
      render :action => 'new'
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(params[:company])
      redirect_to administration_users_path, :notice  => "Successfully updated company."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @company = Company.find(params[:id])
    if @company.users.blank?
      @company.destroy
      redirect_to administration_users_path, :notice => "Successfully deleted company."
    else
      redirect_to administration_users_path, :notice => "Cannot delete company with users."
    end
  end

private
  def check_access
    unless current_user && current_user.admin?
      flash[:notice] = ("Only admins can do management tasks.")
      redirect_to root_path
      return false
    end
  end

end
