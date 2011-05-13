class AccessesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_admin, :only => [:new, :index]

  def index
  	@accesses = Access.all
  end

  def new
  	@project = Project.find(params[:project_id])
    existingusers = @project.users
    @access = Access.new(:project => @project)
    @clients = @project.company.users.clients - existingusers
    @developers = User.developers - existingusers
    @managers = User.managers - existingusers
  end

  def create_self
    access = Access.new(:project_id => params[:project_id], :user_id => current_user.id)
    if access.save
      redirect_to project_path(params[:project_id]), :notice => "Succesfully got you involved into the project."
    else
      redirect_to project_path(params[:project_id]), :notice => "An unexpected error occurred. Please try again."
    end
  end

  def create
    if params[:access][:user_id].kind_of?(Array)
      users = params[:access][:user_id]
      project = params[:access][:project_id]
      users.each do |user|
        existing = Access.find_by_project_id_and_user_id(project, user)
        if existing.blank?
          Access.create(:project_id => project, :user_id => user) unless user.blank?
        end
      end
    else
      Access.create(params[:access])
    end
    # redirect_to accesses_path, :notice => "Successfully added access."
    redirect_to project_path(project), :notice => "Succesfully added user to project space"
  end

  def destroy
    if current_user.id == params[:user_id].to_i || (can? :destroy, Access)
      @access = Access.find_by_project_id_and_user_id(params[:project_id], params[:user_id])
      if @access.destroy
        redirect_to request.referer, :notice => "Successfully removed access."
      else
        redirect_to request.referer, :notice => "Could not remove access."
      end
    else
      redirect_to request.referer, :notice => "You don't have permission to manage access for that user."
    end
  end

  private
  def check_admin
    unless current_user.admin?
      flash[:notice] = ("Only admins can manage accesses.")
      redirect_to root_path
      return false
    end
  end

end