require 'rails_helper'

RSpec.describe "scheduled_meals/show", type: :view do
  before(:each) do
    test_user = FactoryBot.create(:user)
    sign_in test_user

    @scheduled_meal = assign(:scheduled_meal, ScheduledMeal.create!(
      meal: create(:meal),
      schedule: create(:schedule, user: test_user),
      user: test_user
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
