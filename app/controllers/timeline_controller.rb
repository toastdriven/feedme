class TimelineController < ApplicationController
  def articles_for
    @current_date = Time.now
    @articles = RssArticle.find_by_published(@current_date)
  end
  
  def articles_from
    
  end
end
