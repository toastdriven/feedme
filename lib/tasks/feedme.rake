require 'config/environment'

namespace :feedme do
  desc "Pull the latest feeds and populate the database."
  task :pull_feeds do 
    feeds = RssFeed.find(:all)
    
    feeds.each do |feed|
      the_feed_xml = feed.pull_feed
      feed.process_feed(the_feed_xml)
    end
  end
end