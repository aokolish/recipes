class Ingredient < ActiveRecord::Base
  attr_accessible :quantity, :unit_of_measure, :name, :preparation
  validates :name, :presence => true
  # regex should match fractions "1 1/4", decimals "1.5", integers "12"
  validates_format_of :quantity, :with => /(((\d+)\s?)?(\d+)\/(\d+))|((\d+)\.(\d{1,3}))|(\d+)/,
                      :message => "should be an integer, fraction, or decimal number"
  
  def to_s
    # e.g. "2 shallots, minced"
    s = self.quantity 
    s += " #{self.unit_of_measure}" unless self.unit_of_measure.nil?
    s += " #{self.name}" unless self.name.nil?
    s += ", #{self.preparation}" unless self.preparation.nil?
    s
  end
end
