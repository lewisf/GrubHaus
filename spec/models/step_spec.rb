require 'spec_helper'

describe Step do
  
  it { should have_fields(:photo, :description, :time, :duration) }
  it { should validate_presence_of(:description) }

end
