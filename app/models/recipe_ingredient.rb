class RecipeIngredient
  include Mongoid::Document

  field :name, type: String
  field :amount, type: String
  field :unit, type: String

  embedded_in :recipe
  has_one :parent_ingredient, class_name: "Ingredient", inverse_of: :used_in

  validates_presence_of :unit, :amount

end
