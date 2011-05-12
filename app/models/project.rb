class Project < ActiveRecord::Base
  belongs_to :company
  attr_accessible :name, :slug, :description, :company_id, :status

  validates_presence_of :name, :company
  validates_uniqueness_of :name, :slug

  default_scope :order => 'created_at DESC'

  named_scope :active, :conditions => { :archived => 0 }
  named_scope :archived, :conditions => { :archived => 1 }
  named_scope :inquiry, :conditions => { :status => "inquiry" }
  named_scope :upcoming, :conditions => { :status => "upcoming" }
  named_scope :current, :conditions => { :status => "current" }
  named_scope :on_hold, :conditions => { :status => "on_hold" }
  named_scope :review, :conditions => { :status => "review" }

  before_validation :setup_project

  STATUSES = %w[inquiry upcoming current on_hold review]

  def to_slug(ret)
    #strip the string and make it lowercase
    ret = ret.strip.downcase

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with underscore
     ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  

     #convert double underscores to single
     ret.gsub! /_+/,"_"

     #strip off leading/trailing underscore
     ret.gsub! /\A[_\.]+|[_\.]+\z/,""

     ret
  end

  private

  def setup_project
  	if self.slug.blank?
  	  self.slug = self.to_slug(self.name)
  	end
  end

end