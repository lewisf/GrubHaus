class Comment
  include Mongoid::Document

  field :content, type: String
  embeds_many :comments

  validates_presence_of :content

end