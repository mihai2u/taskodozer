class PagesController < ApplicationController
  def home

    if user_signed_in? 
      if current_user.client?
        @projects = current_user.company.projects.active
      else 
        @projects = current_user.projects.active
        # @project.tasks.pending.mine(current_user) + @project.tasks.development.mine(current_user)

        
      end
    end
  end

  def about
  end

end
