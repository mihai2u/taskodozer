class CommentsController < ApplicationController

  before_filter :init_project_and_topic

  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user
    @comment.topic = @topic
    if @comment.save
      if @comment.secret?
        @subscribers = @topic.subscribers.developers + @topic.subscribers.managers
      else
        @subscribers = @topic.subscribers
      end

      @subscribers -= ([] << current_user)
    
      @subscribers.each do |user|
        UserMailer.new_comment_notification(user, @comment).deliver
      end
      redirect_to project_topic_path(@project, @topic)
    else
      redirect_to project_topic_path(@project, @topic), :notice => "Comment was not added"
    end
  end

  def edit
    @comment = Comment.find(params[:comment_id])
  end

  def update
    @comment = Comment.find(params[:comment_id])
    if @comment.update_attributes(params[:comment])
      redirect_to project_topic_path(@project, @topic), :notice => "Successfully edited comment."
    else
      render :action => 'edit'
    end
  end

  def destroy
  end

  private

  def init_project_and_topic
    @project = Project.find(params[:project_id])
    @topic = Topic.find(params[:id])
  end
end
