require 'spec_helper'

describe User do

  it { should have_fields(:username, :email) }
  it { should embed_one(:profile) }
  it { should have_many(:recipes) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence(:username) }
  it { should validate_presence(:username, :email) }

  before :each do
    @user = User.new( username: "Bob", 
                      email: "bobsaget@bob.com",
                      firstname: "Bob", 
                      lastname: "Saget", 
                      profile_photo: nil,
                      tagline: "wut wut" )
  end

end
