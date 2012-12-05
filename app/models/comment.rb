class Comment
  include Mongoid::Document

  field :content, type: String
  embeds_many :comments, as: :commentable
  embedded_in :commentable, polymorphic: true

  validates_presence_of :content

  belongs_to :author, :class_name => "User", :inverse_of => :comments
  belongs_to :parent, :class_name => "Step", :inverse_of => :comments

  attr_accessible :content

end