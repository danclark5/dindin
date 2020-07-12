require 'rails_helper'

RSpec.describe "ingredient_categories/index", type: :view do
  before(:each) do
    assign(:ingredient_categories, [
      IngredientCategory.create!(
        name: "Name"
      ),
      IngredientCategory.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of ingredient_categories" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
  end
end
