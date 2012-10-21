require 'spec_helper'

describe Profile do

  it { should have_fields(:tagline, :first_name, :last_name )}
  it { should be_embedded_in(:user) }
  it { should have_many(:following).of_type(Recipe) }

end
