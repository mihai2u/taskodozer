module ApplicationHelper

def title(page_title)
  content_for(:title) { page_title }
end

def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
 end

def flash_message
    message = ""
    flash.each do |name, msg| 
      message += content_tag :div, msg, :id => "flash_#{name}"
    end
    message.html_safe
end

def admin?
    user_signed_in? && current_user.admin?
end

def developer?
    user_signed_in? && current_user.developer?
end

def client?
    user_signed_in? && current_user.client?
end

def project_completion(project)
    tasks = project.tasks.all.count
    tasks_closed = project.tasks.closed.all.count
    percentage = (tasks != 0) ? ((tasks_closed*1.0/tasks)*100).to_i : 0
end

end
