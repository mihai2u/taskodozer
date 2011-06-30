class TasksController < ApplicationController

  before_filter :authenticate_user!
  before_filter :init_project

  def index
    @filter = params[:filter]
    @tasks = case @filter
      when "all" then @project.tasks
      when "pending" then @project.tasks.pending
      when "development" then @project.tasks.development
      when "completed" then @project.tasks.completed
      when "rejected" then @project.tasks.rejected
      when "reported" then @project.tasks.reported(current_user)
      else @project.tasks.pending.mine(current_user) + @project.tasks.development.mine(current_user)
    end

    if current_user.client?
      @tasks_nb_mine = @project.tasks.pending.mine(current_user).public.all.count + @project.tasks.development.mine(current_user).public.all.count
      @tasks_nb_reported = @project.tasks.reported(current_user).public.all.count
      @tasks_nb_all = @project.tasks.public.all.count
      @tasks_nb_pending = @project.tasks.pending.public.all.count
      @tasks_nb_development = @project.tasks.development.public.all.count
      @tasks_nb_completed = @project.tasks.completed.public.all.count
      @tasks_nb_rejected = @project.tasks.rejected.public.all.count
    else
      @tasks_nb_mine = @project.tasks.pending.mine(current_user).all.count + @project.tasks.development.mine(current_user).all.count
      @tasks_nb_reported = @project.tasks.reported(current_user).all.count
      @tasks_nb_all = @project.tasks.all.count
      @tasks_nb_pending = @project.tasks.pending.all.count
      @tasks_nb_development = @project.tasks.development.all.count
      @tasks_nb_completed = @project.tasks.completed.all.count
      @tasks_nb_rejected = @project.tasks.rejected.all.count
    end
    if current_user.client?
      @tasks = @tasks.public unless @tasks == [] 
    end
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
    duration = @task.duration
    task_update = Hash.new
    @task.update_attributes(:assigned_user_id => current_user.id) unless params[:assigntome].blank?
    @task.update_attributes(:priority => params[:priority]) unless params[:priority].blank?
    @task.update_attributes(:status => params[:status]) unless params[:status].blank?
    @task.update_attributes(:planned_at => Time.now) unless params[:today].blank?
    if @task.update_attributes(params[:task])
      task_update[:status] = @task.status if status != @task.status
      task_update[:priority] = @task.priority if priority != @task.priority
      task_update[:assigned_user_id] = @task.assigned_user_id if assignee != @task.assigned_user_id
      task_update[:added_time] = @task.duration - duration if @task.duration - duration != 0
      unless task_update.blank?
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
      redirect_to request.referer, :notice  => "Successfully updated task."
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
