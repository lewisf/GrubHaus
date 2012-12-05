class Profile
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :tagline, type: String
  field :photo, type: String

  embedded_in :user
  embeds_many :comments, as: :commentable

  attr_accessible :first_name, :last_name, :tagline, :photo

  def name
    "#{first_name} #{last_name}"
  end

end
