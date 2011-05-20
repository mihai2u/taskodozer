class SubscriptionsController < ApplicationController

  before_filter :authenticate_user!

  def create_topic
    Subscription.create(params[:subscription])
    redirect_to project_path(project), :notice => "Succesfully added user to project space"
  end

  def create_topic_self
  	subscription = Subscription.new(:topic_id => params[:topic_id], :user_id => current_user.id)
  	if subscription.save
  		redirect_to request.referer, :notice => "Successfully subscribed."
  	else
  		redirect_to request.referer, :notice => "Could not subscribe."
  	end
  end

  def destroy_topic
	if current_user.id == params[:user_id].to_i || (can? :destroy, Subscription)
      @subscription = Subscription.find_by_topic_id_and_user_id(params[:topic_id], params[:user_id])
      if @subscription.destroy
        redirect_to request.referer, :notice => "Successfully unsubscribed."
      else
        redirect_to request.referer, :notice => "Could not unsubscribe."
      end
    else
      redirect_to request.referer, :notice => "You don't have permission to manage subscriptions for that user."
    end
  end

end