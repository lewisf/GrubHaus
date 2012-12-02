class Recipe
  include Mongoid::Document
  include Mongoid::Copyable

  field :name, type: String
  field :published, type: Boolean, :default => false
  # mount_uploader :photo, RecipePhotoUploader
  field :photo, type: String
  field :description, type: String
  field :prep_time, type: String
  field :cook_time, type: String
  field :ready_in, type: String
  field :serving_size, type: String

  belongs_to :author, :class_name => "User", :inverse_of => :recipes
  embeds_many :recipe_ingredients
  embeds_many :steps
  embeds_many :cookware

  # validates_presence_of :photo, :description, :author, :name
  validates_uniqueness_of :name, :scope => :author

  # Not sure if we're using this relation yet
  belongs_to :parent, :class_name => "Recipe", :inverse_of => :children
  has_many :children, :class_name => "Recipe", :inverse_of => :parent
  has_and_belongs_to_many :favorited, :class_name => "User", :inverse_of => :favorites
  has_many :tags

  before_save :check_publishable

  attr_accessible :name, :published, :description, :prep_time,
                  :cook_time, :ready_in, :serving_size, :recipe_ingredients,
                  :steps, :cookware

  attr_accessible :photo, :photo_cache

  # virtual attributes for use on controllers
  attr_accessor :current_user

  def is_favorited_by_user
    favorited.include? current_user
  end

  def is_authored_by_user
    author == current_user
  end

  def author_name
    author.username
  end


  # Public: Return some recipes based on a query string
  #
  # q - The query string
  #
  # Examples
  #
  #   a = Recipe.search("spaghetti")
  #   #  => <Mongoid::Criteria, ...
  #
  # Returns a Mongoid::Criteria object of recipes

  def self.search(q)
    Rails.logger.info q
    if q.present?
      begin
        criteria.where(:published => true, :name => /#{q}/i)
      rescue
        critieria.where(:published => true, :name => (/#{Regexp.escape(q)}/))
      end
    else
      criteria
    end
  end

  def fork_to(user)
    new_recipe = self.clone
    user.recipes << new_recipe
    new_recipe
  end

  private
  def check_publishable
    name && photo && description && prep_time && 
    cook_time && ready_in && serving_size
  end
end
