require 'rails_helper'

RSpec.describe "scheduled_meals/edit", type: :view do

  before do
    user = create(:user)
    sign_in user

    @scheduled_meal = assign(:scheduled_meal, create(:scheduled_meal, meal: create(:meal, name: "Hot Dogs"), user: user))
    assign(:meals, [create(:meal)])
  end

  it "renders the edit scheduled_meal form" do
    render
    assert_select "form[action=?][method=?]", scheduled_meal_path(@scheduled_meal), "post" do
      assert_select "input[name=?]", "scheduled_meal[meal_id]"
    end
  end
end
