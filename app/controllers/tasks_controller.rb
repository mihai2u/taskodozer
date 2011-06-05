class TasksController < ApplicationController

  before_filter :authenticate_user!
  before_filter :init_project

  def index
    @tasks = @project.tasks
  end

  def show
    @task = Task.find(params[:id])
    @notes = @task.notes.all
    @note = @task.notes.build
    @note.user = current_user
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
      UserMailer.new_task_notification(@task.assigned_user, @task).deliver unless @task.assigned_user_id.blank?
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
    status = @task.status
    priority = @task.priority
    assignee = @task.assigned_user_id
    task_update = Hash.new
    if @task.update_attributes(params[:task])
      task_update[:status] = @task.status if status != @task.status
      task_update[:priority] = @task.priority if priority != @task.priority
      task_update[:assigned_user_id] = @task.assigned_user_id if assignee != @task.assigned_user_id
      if task_update != ""
        last_note = @task.notes.last
        if !last_note.blank? && last_note.updates.blank?
          last_note.updates = task_update
          last_note.save
        else
          newnote = @task.notes.new
          newnote.user_id = current_user
          newnote.updates = task_update
          newnote.save
        end
      end
      notifiers = [@task.user]
      notifiers << @task.assigned_user unless @task.assigned_user_id.blank?
      notifiers -= [current_user]
      notifiers.each do |user|
        UserMailer.update_task_notification(user, @task.notes.last).deliver unless @task.notes.last.content.blank? && @task.notes.last.updates.blank? && @task.notes.last.attachment.blank?
      end
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
