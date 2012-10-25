require 'spec_helper'

describe Comment do

  it { should have_fields(:content) }
  it { should embed_many(:comments) }
  it { should validate_presence_of(:content) }

end