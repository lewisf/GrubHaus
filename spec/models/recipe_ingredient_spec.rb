require 'spec_helper'

describe RecipeIngredient do

  it { should have_fields(:amount, :unit) }
  it { should belong_to_many(:recipes).of_type(Recipe) }

  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:unit) }

end
