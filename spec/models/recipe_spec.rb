require 'spec_helper'

describe Recipe do
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:author) }
  it { should validate_uniqueness_of(:name).scoped_to(:author) }

  before :each do
    @recipe = Recipe.new
  end

  it "should be initialized in draft state" do
    expect(@recipe.draft).to eq(true)
  end

  it "should not allow draft to be true without all the fields filled in." do
    @recipe.draft = false
    expect(@recipe.save).to eq(false)
  end



end
