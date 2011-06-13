require 'nokogiri'
require 'open-uri'
require 'uri'
# require 'chronic_duration'

class Scraper 
  
  def self.scrape(url)
    # protocol must be present in order for me to grab the host
    unless url =~ /(http:\/\/|https:\/\/)/
      url = 'http://' + url
    end
    host = URI.parse(url).host
    
    case host
      when "www.foodnetwork.com"
        @recipe = self.from_food_network(url)
      when "www.cookingchanneltv.com"
        @recipe = self.from_cooking_channel_tv(url)
      else
        @recipe = Recipe.new
        # throw an exception or something?
        # I'd like to notify the user that this domain is not supported
        # And tell them how else they can enter the recipe
    end
    @recipe
  end
  
  def self.from_food_network(url)
    doc = Nokogiri::HTML(open(url))
    
    author = ''
    title = doc.at_css(".fn").text 
    yields = doc.at_css(".yield").text
    time = doc.at_css(".rcp-info :nth-child(1) p").text
    ingredients = ''
    doc.css("li.ingredient").each do |ingredient|
      ingredients += ingredient.text
    end
    directions = ''
    # had to use xpath in order to get this to return a collection of p tags (couldn't get it to work with css)
    doc.xpath('//*[contains(concat( " ", @class, " " ), concat( " ", "instructions", " " ))]//p').each do |direction|
      directions += direction.text
    end
    
    @recipe = Recipe.new( :title => title, :author => '', :source_url => url, :total_time => time, :yield => yields, :ingredients => ingredients, :directions => directions)  
  end
  
  def self.from_cooking_channel_tv(url)
    doc = Nokogiri::HTML(open(url))    
    
    if doc.at_css(".r-attribution .rByline > a")
      author = doc.at_css(".r-attribution .rByline > a").text
    else 
      author = doc.at_css(".r-attribution .rByline").text
    end
    
    title = doc.at_css(".fn").text 
    yields = doc.at_css(".yield").text
    time = doc.at_css(".rspec-value-big").text
    ingredients = ''
    doc.css("li.ingredient").each do |ingredient|
      ingredients += "#{ingredient.text}|"
    end
    directions = ''
    doc.css(".instructions").each do |direction|
      directions += direction.text + '|'
    end
    
    @recipe = Recipe.new( :title => title, :author => author, :source_url => url, :total_time => time, :yield => yields, :ingredients => ingredients, :directions => directions)
  end
end