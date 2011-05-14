class TopicsController < ApplicationController

  before_filter :init_project

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
    @discussions = @project.discussions
    @topic.discussion = @discussions.first
  end

  def create
    @topic = Topic.new(params[:topic])
    @topic.user = current_user
    if @topic.save
      redirect_to project_discussion_path(@project, @topic.discussion), :notice => "Successfully created topic."
    else
      render :action => 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    if @topic.update_attributes(params[:topic])
      redirect_to project_topic_path(@project,@topic), :notice  => "Successfully updated topic."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to project_topics_url(@project), :notice => "Successfully destroyed topic."
  end

  private

  def init_project
    @project = Project.find(params[:project_id])
  end
end
