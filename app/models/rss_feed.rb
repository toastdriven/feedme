class RssFeed < ActiveRecord::Base
  has_many :rss_articles
  
  validates_presence_of :title
  validates_presence_of :url
  
  def process_rss_feed(xml)
    rss = Hpricot.XML(xml)
    
    (rss/:channel/:item).each do |item|
      link = (item/:link).inner_html
      
      if not RssArticle.find_by_link(link)
        rss_article = RssArticle.new
        rss_article.title = (item/:title).inner_html
        rss_article.link = (item/:link).inner_html
        rss_article.author = (item/:author).inner_html
        rss_article.content = (item/:description).inner_html
        # rss_article.published = (item/:)
        rss_article.save()
      end
    end
  end
  
  def test_feed
    f = open('/Users/daniel/Desktop/SW.xml', 'r')
    sw = f.read
    f.close
    
    process_rss_feed(sw)
  end
end
