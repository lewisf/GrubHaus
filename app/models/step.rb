class Step
  include Mongoid::Document

  field :description, type: String
  field :start_time, type: Integer
  field :end_time, type: Integer

  attr_accessible :description, :start_time, :end_time
  validates_presence_of :description
  
end
