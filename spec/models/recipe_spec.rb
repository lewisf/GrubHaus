require 'spec_helper'

describe Recipe do
  
  before :each do
    @recipe = Recipe.new
  end

  it "should be invalid without a title" do
    expect(Recipe.save).to eq(false)
  end

  it "should be invalid without an owner" do
    expect(Recipe.save).to eq(false)
  end

  it "should be initialized in draft state" do
    expect(Recipe.draft).to eq(true)
  end


end
