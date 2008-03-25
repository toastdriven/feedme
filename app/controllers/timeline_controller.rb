class TimelineController < ApplicationController
  def articles_for
    @current_date = Date.today
    @articles = RssArticle.find(:all, :conditions => ['published = ?', @current_date])
  end
  
  def articles_from
    
  end
end
