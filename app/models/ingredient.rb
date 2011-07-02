class Ingredient < ActiveRecord::Base
  attr_accessible :quantity, :unit_of_measure, :name, :preparation
  validates :name, :presence => true
  # regex should match fractions "1 1/4", decimals "1.5", integers "12"
  validates_format_of :quantity, :with => /(((\d+)\s?)?(\d+)\/(\d+))|((\d+)\.(\d{1,3}))|(\d+)/,
                      :message => "should be an integer, fraction, or decimal number"

  def parse(str)
    # parse a string such as '4 small corn tortillas, warmed' and 
    # sets the :quantity, :unit_of_measure, :name, and :preparation for this ingredient
    str.strip!
    unless str.match(/(((\d+)\s?)?(\d+)\/(\d+))|((\d+)\.(\d{1,3}))|(\d+)/).nil?
      qty = str.match(/(((\d+)\s?)?(\d+)\/(\d+))|((\d+)\.(\d{1,3}))|(\d+)/)[0]
      # remove qty portion of string
      str.gsub!(/#{qty}/, '')
      str.strip!
      self.quantity = qty
      
      begin
        first_word = str.match(/\w+\b/)[0].strip
        u = Unit.new("#{qty} #{first_word}")  #if the first word is not a unit, exception will be thrown here
        self.unit_of_measure = first_word
        str.gsub!(/#{first_word}/, '')
        str.strip!
      rescue ArgumentError
        # should I be more specific? meaning, is length an acceptable method of measurement?
      end
    end
    
    comma_index = str.index ',' #index of first comma
    unless comma_index.nil?
      self.name = str[0, comma_index]
      prep = str[comma_index+1,str.length]
      prep.strip!
      self.preparation = prep
    else
      # assuming there is no preparation
      self.name = str
    end
  end
  
  def to_s
    # put everything together like "2 shallots, minced"
    if self.quantity.nil?
      s = ''
    else 
      s = self.quantity
    end
    s += " #{self.unit_of_measure}" unless self.unit_of_measure.nil?
    s += " #{self.name}" unless self.name.nil?
    s += ", #{self.preparation}" unless self.preparation.nil?
    s.strip!
    s
  end
end
