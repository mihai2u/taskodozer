class TopicsController < ApplicationController

  before_filter :init_project

  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = Comment.new
    @comment.secret = 0
    if current_user.client?
      @comments = @topic.comments.public
    else
      @comments = @topic.comments
    end
    @users = @topic.subscribers
    @clients = @topic.subscribers.clients
    @developers = @topic.subscribers.developers + @topic.subscribers.managers
  end

  def new
    @topic = Topic.new
    @discussions = @project.discussions 
    @subscribers = @project.users - ([] << current_user)
    if params[:id].blank?
      discussion = @discussions.first
    else
      discussion = Discussion.find(params[:id]) 
    end
    @topic.discussion = discussion
  end

  def create
    @topic = Topic.new(params[:topic])
    @topic.user = current_user
    if @topic.save
      @topic.subscribers.each do |user|
        UserMailer.new_topic_notification(user, @topic).deliver
      end
      @topic.subscribers << current_user
      @topic.save!
      redirect_to project_discussion_path(@project, @topic.discussion), :notice => "Successfully created topic."
    else
      render :new
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
