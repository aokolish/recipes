class Recipe < ActiveRecord::Base
  validates :title, :author, :ingredients, :directions, :presence => true
  validates_uniqueness_of :source_url   # do not import the same recipe twice  
  before_validation :cleanup_directions
      
  def self.from_import(url)
    @recipe = Scraper.new.scrape(url)   # see models/scraper.rb for scraping code
  end
  
  # storing total_time as an integer. customer getter/setter:
  def total_time
    # output total_time in a format that is easy to read e.g. 1800 becomes '30 minutes'
    unless self[:total_time].nil?
      ChronicDuration.output self[:total_time]
    end
  end
  
  def total_time=(text)
    if text.class == String
      self[:total_time] = ChronicDuration.parse text
    else
      self[:total_time] = text
    end
  end
  
  def directions_array
    self.directions.split('|') 
  end
  
  def change_pipes_to_newlines
    # want to do this in some cases. for example, user is about to edit directions
    self.directions.gsub!(/\|/, "\n\n") unless self.directions =~ /\|/.nil?
  end
  
  private
  
  def cleanup_directions
    if self.directions.nil?
      return nil
    else
      # no harm in running this on directions that are already pipe-delimited
      dirs = self.directions  
    end
    
    # change new lines or breaks to pipes
    dirs.gsub!(/((\r\n)|\n|(<br>)|(<br \/>)|(<br\/>))+/i, '|')
    
    # remove back to back pipes
    dirs.squeeze('|')
    
    # remove leading or trailing pipes
    dirs.gsub!(/(\A\||\|\z)/, '')
    
    # strip whitespace
    final_dirs = dirs.strip
    self.directions = final_dirs
  end
  
end