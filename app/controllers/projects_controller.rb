class ProjectsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_admin, :only => [:new, :create]

  def archive
    @project = Project.find(params[:id])
    @project.archived = 1
    @project.save
    redirect_to projects_url, :notice => "Successfully archived project."
  end

  def reactivate
    @project = Project.find(params[:id])
    @project.archived = 0
    @project.save
    redirect_to projects_url, :notice => "Successfully reactivated project."
  end

  def index
    @filter = params[:filter]

    # if @filter.empty
    #   @projects = Project.active.all
    # else
    #   if @filter == "all"
    #     @projects = Project.@filter.all
    #   else
    # end

    @projects = case @filter
       when "all" then Project.all
       when "archived" then Project.archived
       when "inquiry" then Project.inquiry
       when "upcoming" then Project.upcoming
       when "current" then Project.current
       when "on_hold" then Project.on_hold
       when "review" then Project.review
       else Project.active.all
      end

    @companies = Array.new
    @projects.each do |project|
      @companies << project.company
    end
    @companies.uniq!
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to @project, :notice => "Successfully created project."
    else
      render :action => 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      redirect_to @project, :notice  => "Successfully updated project."
    else
      render :action => 'edit'
    end
  end

private
  def check_admin
    unless current_user.admin?
      flash[:notice] = ("Only admins can create projects.")
      redirect_to root_path
      return false
    end
  end

end
