class Ingredient
  include Mongoid::Document

  field :name, type: String

  has_many :used_in, class_name: "RecipeIngredient", inverse_of: :parent_ingredient
  has_many :substitutes, class_name: "Ingredient"

  validates_presence_of :name
  validates_uniqueness_of :name

end
