require 'spec_helper'

describe User do

  it { should have_fields(:username, :email, :firstname, :lastname, :profile_photo) }
  it { should have_many(:recipes) }
  it { should have_one(:profile) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_presence(:username) }
  it { should validate_presence(:username, :email) }


  before :each do
    @user = User.new(username: "Bob", firstname: "Bob", lastname: "Saget")
  end

  it "should be initialized with a corresponding Profile object" do
    @user.save
    expect(@user.profile).to be_an_instance_of(Profile)
  end

end
