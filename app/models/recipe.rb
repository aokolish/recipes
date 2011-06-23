class Recipe < ActiveRecord::Base
  validates :title, :author, :ingredients, :directions, :presence => true
  validates_uniqueness_of :source_url   # do not import the same recipe twice  
      
  def self.from_import(url)
    @recipe = Scraper.scrape(url)   # see models/scraper.rb for scraping code
  end
  
  #total_time can be stored as an integer??
  def total_time
    # output total_time in a format that is easy to read e.g. 1800 becomes '30 minutes'
    ChronicDuration.output self[:total_time]
  end
  
  def total_time=(text)
    if text.class == String
      self[:total_time] = ChronicDuration.parse text
    else
      self[:total_time] = text
    end
  end
  
end