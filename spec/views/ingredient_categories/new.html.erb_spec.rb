require 'rails_helper'

RSpec.describe "ingredient_categories/new", type: :view do
  before(:each) do
    assign(:ingredient_category, IngredientCategory.new(
      name: "MyString"
    ))
  end

  it "renders new ingredient_category form" do
    render

    assert_select "form[action=?][method=?]", ingredient_categories_path, "post" do

      assert_select "input[name=?]", "ingredient_category[name]"
    end
  end
end
