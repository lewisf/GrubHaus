require 'spec_helper'

describe Recipe do
  
  it { should have_fields(:name, :photo, :description, :prep_time, :cook_time, :ready_in, :serving_size, :draft) }
  it { should embed_many(:steps) }
  it { should embed_many(:cookware) }
  it { should has_many(:tags) }
  it { should have_many(:recipe_ingredients) }
  it { should belong_to(:author).of_type(User) }

  it { should have_one(:parent).of_type(Recipe) }
  it { should have_many(:children).of_type(Recipe) }
  it { should have_many(:followers).as_inverse_of(:following) }

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
