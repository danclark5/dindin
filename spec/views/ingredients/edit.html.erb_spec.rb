require 'rails_helper'

RSpec.describe "ingredients/edit", type: :view do
  before(:each) do
    user = create(:user)
    sign_in user

    @ingredient = assign(:ingredient, Ingredient.create!(
      name: "MyString"
    ))
    assign(:ingredient_categories, [create(:ingredient_category)])
  end

  it "renders the edit ingredient form" do
    render

    assert_select "form[action=?][method=?]", ingredient_path(@ingredient), "post" do

      assert_select "input[name=?]", "ingredient[name]"
    end
  end
end
