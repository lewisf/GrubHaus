class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  validates_presence_of :content

  belongs_to :author, :class_name => "User", :inverse_of => :comments
  belongs_to :parent, :class_name => "Step", :inverse_of => :comments

  attr_accessible :content, :parent

end