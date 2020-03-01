require 'rails_helper'

RSpec.describe "scheduled_meals/new", type: :view do
  before do
    assign(:scheduled_meal, build(:scheduled_meal))
    assign(:meals, [create(:meal)])
  end

  it "renders new scheduled_meal form" do
    render
    assert_select "form[action=?][method=?]", scheduled_meals_path, "post" do
      assert_select "input[name=?]", "scheduled_meal[meal_id]"
    end
  end
end
