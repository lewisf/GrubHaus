class Recipe
  include Mongoid::Document

  field :name, type: String
  field :draft, type: Boolean, :default => true

end
