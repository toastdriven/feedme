class RssArticle < ActiveRecord::Base
  belongs_to :rss_feed
  
  validates_presence_of :rss_feed_id
  validates_numericality_of :rss_feed_id
end
