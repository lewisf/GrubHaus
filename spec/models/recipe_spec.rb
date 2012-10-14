require 'spec_helper'

describe Recipe do
  
  it { should have_fields(:name, :author, :photo, :description) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:author) }
  it { should validate_uniqueness_of(:name).scoped_to(:author) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:photo) }

  before :each do
    @recipe = Recipe.new
  end

  it "should be initialized in draft state" do
    expect(@recipe.draft).to eq(true)
  end

  it "should not allow draft to be true (should not publish) without all the fields filled in." do
    @recipe.draft = false
    expect(@recipe.save).to eq(false)
  end

  it "should be able to find its parent recipe if it has one" do
    @recipe.parent = Recipe.new
    expect(@recipe.parent.class).to eq(Recipe)
  end

end
