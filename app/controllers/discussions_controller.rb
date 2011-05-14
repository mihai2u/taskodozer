class DiscussionsController < ApplicationController

  before_filter :init_project

  def archive
    @discussion = Discussion.find(params[:id])
    @discussion.archived = 1
    @discussion.save
    redirect_to project_discussions_url(@project), :notice => "Successfully archived category."
  end

  def reactivate
    @discussion = Discussion.find(params[:id])
    @discussion.archived = 0
    @discussion.save
    redirect_to project_discussion_url(@project, @discussion), :notice => "Successfully reactivated category."
  end

  def index
    @discussions = Discussion.all
  end

  def show
    @discussion = Discussion.find(params[:id])
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(params[:discussion])
    @discussion.project = @project
    if @discussion.save
      redirect_to @project, :notice => "Successfully created discussion."
    else
      render :action => 'new'
    end
  end

  def edit
    @discussion = Discussion.find(params[:id])
  end

  def update
    @discussion = Discussion.find(params[:id])
    if @discussion.update_attributes(params[:discussion])
      redirect_to project_discussion_path(@project, @discussion), :notice  => "Successfully updated discussion."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @discussion = Discussion.find(params[:id])
    if @discussion.project == @project
      @discussion.destroy
      redirect_to project_discussions_path(@project), :notice => "Successfully destroyed discussion."
    else
      redirect_to project_discussions_path(@project), :notice => "Access denied."
    end
  end

  private

  def init_project
    @project = Project.find(params[:project_id])
  end
end
