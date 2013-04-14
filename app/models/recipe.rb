class Recipe < ActiveRecord::Base
  has_many :favorites
  has_many :reviews
  has_many :users, :through => :favorites
  has_many :pictures, :as => :imageable
  belongs_to :user

  validates :title, :author, :directions, :ingredients, :presence => true
  validates_uniqueness_of :source_url, :allow_nil => true   # do not import the same recipe twice
  validate :ensure_total_time_is_a_time
  before_validation :cleanup_input

  def self.search(search, sort=nil, direction='asc', page=1)
    search = search.downcase
    recipes = Recipe.where('lower(title) like ? OR lower(ingredients) like ? OR lower(directions) like ?', "%#{search}%", "%#{search}%", "%#{search}%")
                    .paginate(:page => page, :per_page => 12)
    recipes = recipes.order(sort + ' ' + direction) if sort

    # remove delimiting pipes
    recipes.each do |recipe|
      recipe.replace_pipes
    end
  end

  def has_rating?
    rating > 0
  end

  def self.from_import(url)
    @recipe = Scraper.new.scrape(url)   # see models/scraper.rb for scraping code
  end

  def favorite_for?(user)
    favorites.exists?(:user_id => user.id)
  end

  def review_count
    reviews.count
  end

  def recent_reviews(limit=3)
    reviews.order("created_at DESC").limit(limit)
  end

  def rating
    Review.avg_rating_for(self)
  end

  # storing total_time as an integer. customer getter/setter:
  # TODO: convert this to a damn string and get rid of this gem!
  def total_time
    # output total_time in a format that is easy to read e.g. 1800 becomes '30 minutes'
    unless self[:total_time].nil?
      ChronicDuration.output self[:total_time]
    end
  end

  def total_time=(text)
    begin
      self[:total_time] = ChronicDuration.parse text
    rescue NoMethodError, ChronicDuration::DurationParseError => e
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

  def added_by_author?
    user.username == author
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
