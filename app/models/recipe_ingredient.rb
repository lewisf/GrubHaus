class RecipeIngredient
  include Mongoid::Document

  field :name, type: String
  field :amount, type: String
  field :unit, type: String

  embedded_in :recipe
  has_one :parent_ingredient, class_name: "Ingredient", inverse_of: :used_in

  attr_accessible :name, :amount, :unit, :recipe, :parent_ingredient

  validates_presence_of :name

  # Public: Override default save method so that the recipe ingredient is matched
  #         up with a parent ingredient (same name, just not recipe specific) on save.
  #
  # Examples
  #
  #   RecipeIngredient.new(:name => "Oregano", :amount => "1 1/2", :unit => "Tbsp")
  #   # => 
  #
  # 
  def self.save
    p = Ingredient.where(:name => name).first || Ingredient.create!(:name => name)
    p.used_in << self
    p.save
    super(save)
  end

end
