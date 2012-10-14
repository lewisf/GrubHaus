require 'spec_helper'

describe Ingredient do

  it { should have_fields(:name) }
  it { should have_many(:substitutes).of_type(Ingredient) }

end
