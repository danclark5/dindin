require 'rails_helper'

RSpec.describe "scheduled_meals/index", type: :view do
  before do
    user = create(:user)
    sign_in user

    create(:scheduled_meal, meal: create(:meal, name: "Hot Dogs"), user: user)
    create(:scheduled_meal, meal: create(:meal, name: "Burgers"), user: user)
    start_date = DateTime.now
    end_date = start_date + 7.days
    assign(:scheduled_meals, ScheduledMeal
      .joins("right join generate_series('#{start_date.strftime('%F')}', '#{end_date.strftime('%F')}', '1 day'::interval) as dates on dates = scheduled_meals.date")
      .where("scheduled_meals.user_id = ? or scheduled_meals.user_id is null", user.id)
      .select("dates as schedule_date", :id, :meal_id)
      .order(schedule_date: :asc).all
    )
  end

  it "renders a list of scheduled_meals" do
    render
    expect(rendered).to match /Hot Dogs/
    expect(rendered).to match /Burgers/
  end
end
