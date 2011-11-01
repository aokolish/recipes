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
    
    author = doc.css('p.author a').inner_text
    title = doc.at_css(".fn").text 
    
    if doc.at_css("#recipe-meta .rm-block-wrap >div:nth-child(2) > dl:first-child dd")
      yields = doc.at_css("#recipe-meta .rm-block-wrap >div:nth-child(2) > dl:first-child dd").text
    elsif doc.at_css("#recipe-meta :nth-child(3) .clrfix")
      yields = doc.at_css("#recipe-meta :nth-child(3) .clrfix").text
    else
      yields = nil
    end

    if doc.at_css(".rcp-info :nth-child(1) p")
      time = doc.at_css(".rcp-info :nth-child(1) p").text
    else
      time = doc.at_css("dd.duration").text
    end
    ingredients = ''
    doc.css("li.ingredient").each do |ingredient|
      ingredients += "#{ingredient.text}|"
    end
    directions = ''
    doc.css('div.instructions > p').each do |direction|
      directions += direction.text + '|'
    end
    
    @recipe = Recipe.new( :title => title, :author => author, :source_url => @url, :total_time => time, 
                          :yield => yields, :ingredients => ingredients, :directions => directions)  
  end
  
  def from_cooking_channel_tv
    doc = Nokogiri::HTML(open(@url))    
    
    if doc.at_css(".r-attribution .rByline > a")
      author = doc.at_css(".r-attribution .rByline > a").text
    else 
      # remove html inside the element I'm going to use
      doc.css(".r-attribution .rByline *").remove
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
      
      if direction.at_css('p')
        # there are p tags in here
        # add a pipe before each p tag
        direction.search('p').each do |p| 
          p.before("|")
        end
      end
      
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