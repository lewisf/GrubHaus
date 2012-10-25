require 'spec_helper'

describe RecipeIngredient do

  it { should have_fields(:amount, :unit) }
  it { should be_embedded_in(:recipe) }
  it { should have_one(:parent_ingredient) }

  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:unit) }

end
