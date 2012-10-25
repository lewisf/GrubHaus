class Comment
  include Mongoid::Document

  field :content, type: String
  embeds_many :comments, as: :commentable
  embedded_in :commentable, polymorphic: true

  validates_presence_of :content

end