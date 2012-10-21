class Profile
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :tagline, type: String

  embedded_in :user
  has_many :favorites, :class_name => "Recipe"

end
