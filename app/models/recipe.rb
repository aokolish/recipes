require 'nokogiri'
require 'open-uri'
require 'uri'

class Recipe < ActiveRecord::Base
  
  # TODO: improve how I handle recipe times
      
  def self.from_import(url)
    # protocol must be present in order for me to grab the host
    unless url =~ /(http:\/\/|https:\/\/)/
      url = 'http://' + url
    end
    host = URI.parse(url).host
    
    case host
      when "www.foodnetwork.com"
      @recipe = Recipe.from_food_network(url)
      when "www.cookingchanneltv.com"
        @recipe = Recipe.from_cooking_channel_tv(url)
      else
        # do something else?
    end
    @recipe
    
  end
  
private 
  
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
    
    author = doc.at_css("#sni-w-hd .rByline a").text
    title = doc.at_css(".fn").text 
    yields = doc.at_css(".yield").text
    time = doc.at_css(".rspec-value-big").text
    ingredients = ''
    doc.css("li.ingredient").each do |ingredient|
      ingredients += "#{ingredient.text} <br />"
    end
    directions = doc.at_css(".instructions").text
    
    
    @recipe = Recipe.new( :title => title, :author => author, :source_url => url, :total_time => time, :yield => yields, :ingredients => ingredients, :directions => directions)
  end
end
