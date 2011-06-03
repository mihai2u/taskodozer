class TasksController < ApplicationController

  before_filter :authenticate_user!
  before_filter :init_project

  def index
    @tasks = @project.tasks
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @task.user = current_user
  end

  def create
    @task = Task.new(params[:task])
    @task.user = current_user
    @task.project = @project
    if @task.save
      redirect_to project_task_path(@project,@task), :notice => "Successfully created task."
    else
      render :action => 'new'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(params[:task])
      redirect_to project_task_path(@project,@task), :notice  => "Successfully updated task."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to project_tasks_path(@project), :notice => "Successfully destroyed task."
  end

  private

  def init_project
    @project = Project.find(params[:project_id])
  end

end
