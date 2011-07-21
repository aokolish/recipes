class Recipe < ActiveRecord::Base
  validates :title, :author, :directions, :ingredients, :presence => true
  validates_uniqueness_of :source_url   # do not import the same recipe twice  
  validate :ensure_total_time_is_a_time
  before_validation :cleanup_input
      
  def self.from_import(url)
    @recipe = Scraper.new.scrape(url)   # see models/scraper.rb for scraping code
  end
  
  # storing total_time as an integer. customer getter/setter:
  def total_time
    # output total_time in a format that is easy to read e.g. 1800 becomes '30 minutes'
    unless self[:total_time].nil?
      begin
        ChronicDuration.output self[:total_time]
      rescue
        self[:total_time] = self.total_time_before_type_cast
      end
    end
  end
  
  def total_time=(text)
    begin
      self[:total_time] = ChronicDuration.parse text
    rescue
      self[:total_time] = text
    end
  end
  
  def directions_array
    self.directions.split('|') 
  end
  
  def ingredients_array
    self.ingredients.split('|') 
  end
  
  def replace_pipes(sep = "\n\n", attrs = [:directions,:ingredients])
    # want to do this in some cases. for example, user is about to edit directions
    attrs.each do |attr|
      self[attr].gsub!(/\|/, sep) unless self[attr] =~ /\|/.nil?
    end  
  end
  
  private
  
  def cleanup_input
    [:directions,:ingredients].each do |attr|
      unless self[attr].nil?
        # no harm in running this on attributes that are already pipe-delimited
        str = self[attr]        
        # change new lines or breaks to pipes
        str.gsub!(/((\r\n)|\n|(<br>)|(<br \/>)|(<br\/>))+/i, '|')
        # remove back to back pipes
        str.squeeze!('|')
        # strip whitespace
        str.strip!
        # remove leading or trailing pipes
        str.gsub!(/(\A\||\|\z)/, '')
        # ensure that no blank items are in the string e.g. "...| |...."
        arr = str.split('|').delete_if {|item| item.blank?}
        self[attr] = arr.join("|")
      end
    end
   
    [:title,:author,:yield ].each do |attr|
      unless self[attr].nil?
        self[attr].strip!
      end
    end
  end
  
  def ensure_total_time_is_a_time
    unless self[:total_time].nil?
      begin
        ChronicDuration.parse total_time
      rescue
        errors.add(:total_time, "must be a time such as '1 hour' or '45 minutes'")
      end
    end
  end
  
end