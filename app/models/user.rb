class User < ActiveRecord::Base
  has_many :favorites
  has_many :reviews
  has_many :recipes, :through => :favorites
  has_many :authored_recipes, :class_name => 'Recipe'

  attr_accessible :email, :password, :password_confirmation
  attr_accessor :password
  before_save :encrypt_password

  validates :password, :presence => true, :confirmation => true, :length => { :minimum => 4 }
  validates :email, :presence => true, :uniqueness => true, 
            :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => 'is an invalid format' }

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password,  password_salt)
    end
  end

  def author?(recipe)
    Recipe.exists?(:id => recipe, :user_id => self.id)
  end

  def has_reviewed?(recipe)
    Review.where(recipe_id: recipe.id, user_id: self.id).count > 0
  end
end
