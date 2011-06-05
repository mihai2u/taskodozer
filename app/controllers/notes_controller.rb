class NotesController < ApplicationController

  before_filter :authenticate_user!
  before_filter :init_project_and_task

  def create
    @note = Note.new(params[:note])
    @note.user = current_user
    @note.task = @task
    if @note.save
      redirect_to project_task_path(@project, @task), :notice => "Successfully created note."
    else
      render :action => 'new'
    end
  end

  def edit
    @note = Note.find(params[:note_id])
  end

  def update
    @note = Note.find(params[:note_id])
    if @note.update_attributes(params[:note])
      redirect_to project_task_path(@project, @task), :notice  => "Successfully updated note."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @note = Note.find(params[:note_id])
    @note.destroy
    redirect_to project_task_path(@project, @task), :notice => "Successfully destroyed note."
  end

  private

  def init_project_and_task
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
  end

end
