require 'rails_helper'

RSpec.describe "ingredient_categories/show", type: :view do
  before(:each) do
    @ingredient_category = assign(:ingredient_category, IngredientCategory.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
