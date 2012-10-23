class Recipe
  include Mongoid::Document

  field :name, type: String
  field :published, type: Boolean, :default => false
  field :photo, type: String
  field :description, type: String
  field :prep_time, type: Integer
  field :cook_time, type: Integer
  field :ready_in, type: Integer
  field :serving_size, type: Integer

  belongs_to :author, :class_name => "User"
  embeds_many :recipe_ingredients

  before_save :check_publishable

  private
  def check_publishable
    name && photo && description && prep_time && 
    cook_time && ready_in && serving_size
  end
end
