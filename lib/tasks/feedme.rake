require 'config/environment'

namespace :feedme do
  desc "Pull the latest feeds and populate the database."
  task :pull_feeds do 
    feeds = RssFeed.find(:all)
    
    feeds.each do |feed|
      begin
        the_feed_xml = feed.pull_feed
        feed.process_feed(the_feed_xml)
      rescue RuntimeError => e
        # Silent but deadly...well, not so much.
        # Let's note this and move on to the next feed.
        puts e
      end
    end
  end
end