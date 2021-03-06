class UserMailer < ActionMailer::Base
  default :from => "me@mehigh.biz"

  def new_topic_notification(user, topic)
  	@topic = topic
  	@user = user
	mail(:to => user.email, :subject => "New Topic")
  end

  def new_comment_notification(user, comment)
  	@comment = comment
  	@topic = comment.topic
  	@discussion = @topic.discussion
  	@project = @discussion.project
  	@user = user
  	@subscribers = []
    if @comment.secret?
      @subscribers_arr = @topic.subscribers.developers + @topic.subscribers.managers
    else
      @subscribers_arr = @topic.subscribers
    end
  	@subscribers_arr.each do |subscriber|
  		@subscribers << subscriber.username
  	end
  	mail(:to => user.email, :subject => "Re: [#{@comment.topic.discussion.project.name}] - #{@comment.topic.title}")
  end

  def new_task_notification(user, task)
    @task = task
    @user = user
  mail(:to => user.email, :subject => "New Task")
  end

  def update_task_notification(user, note)
    @user = user
    @note = note
    @task = @note.task
    @project = @task.project
    mail(:to => user.email, :subject => "Re: [#{@project.name}] #{@task.name} - updated")
  end
end
