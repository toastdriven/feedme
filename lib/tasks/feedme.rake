require 'config/environment'

namespace :feedme do
  desc "Pull the latest feeds and populate the database."
  task :pull_feeds do 
    feeds = RssFeed.find(:all)
    
    feeds.each do |feed|
      the_rss = feed.pull_feed
      feed.process_rss_feed(the_rss)
    end
  end
end