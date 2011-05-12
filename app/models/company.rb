class Company < ActiveRecord::Base
  has_many :users
  has_many :projects

  attr_accessible :name, :country, :address, :slug

  validates_presence_of :name
  validates_uniqueness_of :name, :slug

  before_validation :setup_slug

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

  def setup_slug
    if self.slug.blank?
    	self.slug = self.to_slug(self.name)
    end
  end
end
