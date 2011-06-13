class Recipe < ActiveRecord::Base
  validates :title, :author, :ingredients, :directions, :presence => true
  validates_uniqueness_of :source_url   # do not import the same recipe twice  
      
  def self.from_import(url)
    @recipe = Scraper.scrape(url)   # see models/scraper.rb for scraping code
  end
  
  #total_time can be stored as an integer??
  # def total_time
  #   ChronicDuration.output time_spent
  # end
  # 
  # def total_time= text
  #   self.total_time = ChronicDuration.parse text
  #   # logger.debug "time_spent: '#{self.time_spent_text}' for text '#{text}'"
  # end
  
end