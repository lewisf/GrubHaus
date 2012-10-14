require 'spec_helper'

describe Profile do
  it { should be_embedded_in(:user).as_inverse_of(:profile) }
  it { should have_many(:favorites).of_type(Recipe) }
end
