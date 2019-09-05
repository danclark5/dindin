require 'rails_helper'

RSpec.describe "scheduled_meals/index", type: :view do
  before(:each) do
    assign(:scheduled_meals, [
      ScheduledMeal.create!(
        :meal => nil,
        :meal_type => nil
      ),
      ScheduledMeal.create!(
        :meal => nil,
        :meal_type => nil
      )
    ])
  end

  it "renders a list of scheduled_meals" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
