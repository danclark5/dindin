require 'rails_helper'

RSpec.describe "scheduled_meals/edit", type: :view do

  before(:each) do
    test_user = FactoryBot.create(:user)
    sign_in test_user

    @scheduled_meal = assign(:scheduled_meal, ScheduledMeal.create!(
      meal: create(:meal),
      schedule: create(:schedule, user: test_user),
      user: test_user

    ))
    assign(:meals, [double("A meal", name: "Something", id: 1)])
  end

  it "renders the edit scheduled_meal form" do
    render

    assert_select "form[action=?][method=?]", scheduled_meal_path(@scheduled_meal), "post" do

      assert_select "select[name=?]", "scheduled_meal[meal_id]"
    end
  end
end
