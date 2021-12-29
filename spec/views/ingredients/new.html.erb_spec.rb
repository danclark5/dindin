require 'rails_helper'

RSpec.describe "ingredients/new", type: :view do
  before(:each) do
    user = create(:user)
    sign_in user

    assign(:ingredient, Ingredient.new(
      name: "MyString"
    ))
    assign(:ingredient_categories, [create(:ingredient_category)])
  end

  it "renders new ingredient form" do
    render

    assert_select "form[action=?][method=?]", ingredients_path, "post" do

      assert_select "input[name=?]", "ingredient[name]"
    end
  end
end
