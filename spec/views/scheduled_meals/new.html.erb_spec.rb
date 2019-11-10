require 'rails_helper'

RSpec.describe "scheduled_meals/new", type: :view do
  before(:each) do
    assign(:scheduled_meal, ScheduledMeal.new(
      :meal => nil,
    ))
    assign(:meals, [double("A meal", name: "Something", id: 1)])
  end

  it "renders new scheduled_meal form" do
    render

    assert_select "form[action=?][method=?]", scheduled_meals_path, "post" do

      assert_select "select[name=?]", "scheduled_meal[meal_id]"
    end
  end
end
