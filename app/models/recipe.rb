class Recipe
  include Mongoid::Document

  field :name, type: String
  field :published, type: Boolean, :default => false
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
  has_many :favorited, :class_name => "User", :inverse_of => :favorites
  has_many :tags

  before_save :check_publishable

  attr_accessible :name, :published, :photo, :description, :prep_time,
                  :cook_time, :ready_in, :serving_size

  private
  def check_publishable
    name && photo && description && prep_time && 
    cook_time && ready_in && serving_size
  end
end
