class PagesController < ApplicationController
  def home

    if user_signed_in? 
      if current_user.client?
        @projects = current_user.company.projects.active
        @projects_nb_all      = current_user.company.projects.all.count
        @projects_nb_archived = current_user.company.projects.archived.count
        @projects_nb_inquiry  = current_user.company.projects.active.inquiry.count
        @projects_nb_upcoming = current_user.company.projects.active.upcoming.count
        @projects_nb_current  = current_user.company.projects.active.current.count
        @projects_nb_on_hold  = current_user.company.projects.active.on_hold.count
        @projects_nb_review   = current_user.company.projects.active.review.count
        @projects_nb_active   = current_user.company.projects.active.count
      else 
        @projects = current_user.projects.active
      end
    else
      # 
    end
  end

  def about
  end

end
