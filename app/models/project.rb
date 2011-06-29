class Project < ActiveRecord::Base
  belongs_to :company
  has_many :accesses
  has_many :users, :through => :accesses, :uniq => true
  has_many :discussions
  has_many :topics, :through => :discussions
  has_many :tasks
  
  attr_accessible :name, :slug, :description, :company_id, :status, :repository

  validates_presence_of :name, :company
  validates_uniqueness_of :name, :slug

  default_scope :order => 'created_at DESC'

  scope :active, :conditions => { :archived => 0 }
  scope :archived, :conditions => { :archived => 1 }
  scope :inquiry, :conditions => { :status => "inquiry" }
  scope :upcoming, :conditions => { :status => "upcoming" }
  scope :current, :conditions => { :status => "current" }
  scope :on_hold, :conditions => { :status => "on_hold" }
  scope :review, :conditions => { :status => "review" }

  before_validation :setup_project
  after_save :setup_discussions

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

  def setup_discussions
    self.discussions.create(:title => "General")
  end
end
