class TimelineController < ApplicationController
  before_filter :get_feeds
  
  def articles_for
    if params[:year].nil? or params[:month].nil? or params[:day].nil?
      @current_date = Time.now
    else
      @current_date = Time.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")
    end
    
    @start_at = @current_date.end_of_day
    @end_at = @current_date.beginning_of_day
    @articles = RssArticle.find :all, 
                                :conditions => ['published BETWEEN ? AND ?', @end_at, @start_at],
                                :order => 'published DESC'
  end
  
  
  protected
  def get_feeds
    @feeds = RssFeed.find :all, :order => 'title'
  end
end
