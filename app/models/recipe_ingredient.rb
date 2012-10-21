class RecipeIngredient
  include Mongoid::Document

  field :name, type: String
  field :amount, type: Integer
  field :unit, type: Float

  embedded_in :recipe
  has_one :parent_ingredient, class_name: "Ingredient", inverse_of: :used_in

end
