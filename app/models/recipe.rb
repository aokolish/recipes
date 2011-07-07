class Recipe < ActiveRecord::Base
  validates :title, :author, :directions, :presence => true
  validates_uniqueness_of :source_url   # do not import the same recipe twice  
  # validates_associated :ingredients
  before_validation :cleanup_directions_and_ingredients
      
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
  
  def ingredients_array
    self.ingredients.split('|') 
  end
  
  def change_pipes_to_newlines
    # want to do this in some cases. for example, user is about to edit directions
    [:directions,:ingredients].each do |attr|
      self[attr].gsub!(/\|/, "\n\n") unless self[attr] =~ /\|/.nil?
    end  
  end
  
  private
  
  def cleanup_directions_and_ingredients
    [:directions,:ingredients].each do |attr|
      if self[attr].nil?
        return nil
      else
        # no harm in running this on attributes that are already pipe-delimited
        attr = self[attr]  
      end
    
      # change new lines or breaks to pipes
      attr.gsub!(/((\r\n)|\n|(<br>)|(<br \/>)|(<br\/>))+/i, '|')
    
      # remove back to back pipes
      attr.squeeze('|')
    
      # remove leading or trailing pipes
      attr.gsub!(/(\A\||\|\z)/, '')
    
      # strip whitespace
      final = attr.strip
      self[attr] = final
    end
  end
  
end