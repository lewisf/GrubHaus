class Tag
  include Mongoid::Document

  field :name, type: String

  has_and_belongs_to_many :recipes

  validates_presence_of :name
  validates_uniqueness_of :name

end
