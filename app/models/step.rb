class Step
  include Mongoid::Document

  field :photo, type: String
  field :description, type: String
  field :time, type: DateTime
  field :duration, type: Integer

  validates_presence_of :description
  
end
