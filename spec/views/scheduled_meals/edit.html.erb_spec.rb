require 'rails_helper'

RSpec.describe "scheduled_meals/edit", type: :view do
  before(:each) do
    @scheduled_meal = assign(:scheduled_meal, ScheduledMeal.create!(
      :meal => nil,
      :meal_type => nil
    ))
  end

  it "renders the edit scheduled_meal form" do
    render

    assert_select "form[action=?][method=?]", scheduled_meal_path(@scheduled_meal), "post" do

      assert_select "input[name=?]", "scheduled_meal[meal_id]"

      assert_select "input[name=?]", "scheduled_meal[meal_type_id]"
    end
  end
end
