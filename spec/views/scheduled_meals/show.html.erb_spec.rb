require 'rails_helper'

RSpec.describe "scheduled_meals/show", type: :view do
  before(:each) do
    @scheduled_meal = assign(:scheduled_meal, ScheduledMeal.create!(
      :meal => nil,
      :meal_type => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
