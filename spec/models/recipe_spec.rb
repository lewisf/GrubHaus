require 'spec_helper'

describe Recipe do
  
  it { should have_fields(:name, :photo, :description, :prep_time, :cook_time, :ready_in, :serving_size, :published) }
  it { should embed_many(:steps) }
  it { should embed_many(:cookware) }
  it { should have_many(:tags) }
  it { should embed_many(:recipe_ingredients) }
  it { should belong_to(:author).of_type(User) }

  it { should belong_to(:parent).of_type(Recipe).as_inverse_of(:children) }
  it { should have_many(:children).of_type(Recipe) }
  it { should have_many(:favorited).as_inverse_of(:favorites) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:author) }
  it { should validate_uniqueness_of(:name).scoped_to(:author) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:photo) }

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:photo) }
  it { should allow_mass_assignment_of(:description) }
  it { should allow_mass_assignment_of(:prep_time) }
  it { should allow_mass_assignment_of(:cook_time) }
  it { should allow_mass_assignment_of(:ready_in) }
  it { should allow_mass_assignment_of(:serving_size) }
  it { should allow_mass_assignment_of(:published) }

  before :each do
    @recipe = Recipe.new
  end

  it "should be initialized in draft state" do
    expect(@recipe.published).to eq(false)
  end

  it "should not should not publish without all the fields filled in." do
    @recipe.published = true
    @recipe.save
    expect(Recipe.count).to eq(0)
  end

  it "should be able to find its parent recipe if it has one" do
    @recipe.parent = Recipe.new
    expect(@recipe.parent.class).to eq(Recipe)
  end

end
