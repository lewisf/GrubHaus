class Step
  include Mongoid::Document

  field :description, type: String
  field :start_time, type: Integer
  field :end_time, type: Integer

  embeds_many :comments, as: :commentable

  attr_accessible :description, :start_time, :end_time
  validates_presence_of :description

end
