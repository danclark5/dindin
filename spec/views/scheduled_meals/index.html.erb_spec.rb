require 'rails_helper'

RSpec.describe "scheduled_meals/index", type: :view do
  before(:each) do
    test_user = FactoryBot.create(:user)
    sign_in test_user

    assign(:scheduled_meals, [
      ScheduledMeal.create!(
        meal: create(:meal),
        schedule: create(:schedule, user: test_user),
        user: test_user
      ),
      ScheduledMeal.create!(
        meal: create(:meal),
        schedule: create(:schedule, user: test_user),
        user: test_user
      )
    ])
  end

  it "renders a list of scheduled_meals" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
