require 'spec_helper'

describe User do

  it { should have_fields(:username, :email) }
  it { should embed_one(:profile) }
  it { should have_many(:recipes) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }

  it { should have_many(:following).of_type(User).as_inverse_of(:followers) }
  it { should have_many(:followers).of_type(User).as_inverse_of(:following)}
  it { should have_many(:favorites).of_type(Recipe) }

  before :each do
    @user = User.new( username: "Bob", 
                      email: "bobsaget@bob.com",
                      firstname: "Bob", 
                      lastname: "Saget", 
                      profile_photo: nil,
                      tagline: "wut wut" )
  end

end
