class RssFeed < ActiveRecord::Base
  has_many :rss_articles
  
  validates_presence_of :title
  validates_presence_of :url
end
