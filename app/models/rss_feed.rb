require 'hpricot'
require 'open-uri'

class RssFeed < ActiveRecord::Base
  has_many :rss_articles, :dependent => :delete_all
  
  validates_presence_of :title
  validates_presence_of :url
  
  def process_rss_feed(xml)
    rss = Hpricot.XML(xml)
    time_offset = 1
    
    (rss/:channel/:item).each do |item|
      link = (item/:link).inner_html
      
      if not RssArticle.find_by_link(link)
        rss_article = RssArticle.new
        rss_article.rss_feed = self
        rss_article.title = (item/:title).inner_html
        rss_article.link = (item/:link).inner_html
        rss_article.author = (item/:author).inner_html
        rss_article.content = (item/:description).inner_html
        rss_article.published = (item/:pubDate).inner_html
        
        if not rss_article.published
          rss_article.published = Time.now - time_offset.hours
          time_offset += 1
        end
        
        # Fix the content to be HTML once again...
        rss_article.title = bring_back_the_html(rss_article.title)
        rss_article.content = bring_back_the_html(rss_article.content)
        
        rss_article.save()
      end
    end
  end
  
  def pull_feed
    the_rss = ""
    
    begin
      f = open(self.url, 'r')
      the_rss = f.read()
      f.close 
    rescue
      # For now, do nothing. Some kind of notification might be nice here.
    end
    
    the_rss
  end
  
  def bring_back_the_html(stringy)
    stringy.gsub!('&lt;', '<')
    stringy.gsub!('&gt;', '>')
    stringy.gsub!('&amp;', '&')
    stringy.gsub!('&#39;', "'")
    stringy.gsub!('&quot;', '"')
    stringy
  end
  
  def test_feed
    f = open('/Users/daniel/Desktop/SW.xml', 'r')
    sw = f.read
    f.close
    
    process_rss_feed(sw)
  end
end
