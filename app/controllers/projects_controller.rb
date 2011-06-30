class ProjectsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :check_admin, :only => [:edit, :update]
  before_filter :check_access, :only => [:show]

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
    if current_user.client?
      @projects_nb_all      = current_user.company.projects.all.count
      @projects_nb_archived = current_user.company.projects.archived.count
      @projects_nb_inquiry  = current_user.company.projects.active.inquiry.count
      @projects_nb_upcoming = current_user.company.projects.active.upcoming.count
      @projects_nb_current  = current_user.company.projects.active.current.count
      @projects_nb_on_hold  = current_user.company.projects.active.on_hold.count
      @projects_nb_review   = current_user.company.projects.active.review.count
      @projects_nb_active   = current_user.company.projects.active.count
      @projects = case @filter
        when "all" then current_user.company.projects.all
        when "archived" then current_user.company.projects.archived
        when "inquiry" then current_user.company.projects.active.inquiry
        when "upcoming" then current_user.company.projects.active.upcoming
        when "current" then current_user.company.projects.active.current
        when "on_hold" then current_user.company.projects.active.on_hold
        when "review" then current_user.company.projects.active.review
      else current_user.company.projects.active
      end
    else
      @projects_nb_all      = Project.all.count
      @projects_nb_archived = Project.archived.count
      @projects_nb_inquiry  = Project.active.inquiry.count
      @projects_nb_upcoming = Project.active.upcoming.count
      @projects_nb_current  = Project.active.current.count
      @projects_nb_on_hold  = Project.active.on_hold.count
      @projects_nb_review   = Project.active.review.count
      @projects_nb_active   = current_user.projects.active.count
      @projects = case @filter
        when "all" then Project.all
        when "archived" then Project.archived
        when "inquiry" then Project.active.inquiry
        when "upcoming" then Project.active.upcoming
        when "current" then Project.active.current
        when "on_hold" then Project.active.on_hold
        when "review" then Project.active.review
        else current_user.projects.active
      end
    end

      @companies = Array.new
      @projects.each do |project|
        @companies << project.company
      end
      @companies.uniq!
  end

  def show
    @project = Project.find(params[:id])
    @users = @project.users
    @clients = @users.clients
    @developers = @users.developers + @users.managers
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      unless @project.repository == 0
        result = `./svncreator.sh #{@project.slug}`
        @project.repository = "svn://svn@svn.adesigns.eu/#{@project.slug}"
        @project.save
      end
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
      flash[:notice] = ("You don't have permission to manage projects.")
      redirect_to root_path
      return false
    end
  end

  def check_access
    unless current_user.admin? || current_user.developer? || current_user.company == Project.find(params[:id]).company
      redirect_to projects_path, :notice  => "You don't have access to that project space."
    end
  end

end
