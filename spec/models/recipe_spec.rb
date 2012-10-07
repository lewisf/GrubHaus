require 'spec_helper'

describe Recipe do
  
  before :each do
    @recipe = Recipe.new(title: "Title", 
                         owner: "Owner",
                         steps: [],
                         ingredients: [])
  end

  it "should be true" do
    expect(true).to eq(true)
  end

end
