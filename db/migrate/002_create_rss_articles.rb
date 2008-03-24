class CreateRssArticles < ActiveRecord::Migration
  def self.up
    create_table :rss_articles do |t|
      t.integer :rss_feed_id
      t.string :title, :link, :author
      t.text :content
      t.datetime :published
      t.timestamps
    end
  end

  def self.down
    drop_table :rss_articles
  end
end
