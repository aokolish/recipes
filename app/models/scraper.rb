require 'nokogiri'
require 'open-uri'
require 'uri'

class Scraper 
  
  def scrape(url)
    @url = url
    # protocol must be present in order for me to grab the host
    unless @url =~ /(http:\/\/|https:\/\/)/
      url = 'http://' + @url
    end
    host = URI.parse(@url).host
    
    case host
      when "www.foodnetwork.com"
        @recipe = from_food_network
      when "www.cookingchanneltv.com"
        @recipe = from_cooking_channel_tv
      else
        @recipe = Recipe.new
        # throw an exception or something?
        # I'd like to notify the user that this domain is not supported
        # And tell them how else they can enter the recipe
    end
    @recipe
  end

  private
  
  def from_food_network
    doc = Nokogiri::HTML(open(@url))
    
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
    
    @recipe = Recipe.new( :title => title, :author => '', :source_url => @url, :total_time => time, 
                          :yield => yields, :ingredients => ingredients, :directions => directions)  
  end
  
  def from_cooking_channel_tv
    doc = Nokogiri::HTML(open(@url))    
    
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
      direction = replace_breaks_with_pipes(direction)
      ap direction
      directions += direction.content + '|'
    end
    
    @recipe = Recipe.new( :title => title, :author => author, :source_url => @url, :total_time => time, 
                          :yield => yields, :ingredients => ingredients, :directions => directions)
  end
  
  def replace_breaks_with_pipes(node)
    # searches a node for br tags and replaces with pipes
    node.search('br').each{ |br| br.replace("|") }
    node
  end
end