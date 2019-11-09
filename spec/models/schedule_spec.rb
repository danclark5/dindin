require 'rails_helper'

RSpec.describe Schedule, type: :model do

  subject(:schedule) { create(:scheduled_meal).schedule }
  let(:scheduled_meal) { schedule.scheduled_meals.first }

  describe "#included_dates" do
    context "schedule has a set of valid start and end dates" do
      it "returns 7 dates" do
        expect(schedule.included_dates.length).to eq(7)
      end
    end

    context "schedule has a start date that is after the end date" do
      subject(:schedule) { build(:schedule, start_date: 6.days.from_now, end_date: 3.days.from_now) }
      it "returns 0 dates" do
        expect(schedule.included_dates.length).to eq(0)
      end
    end
  end
  describe "#meal_for" do
    context "for a period that has a meal scheduled" do
      it "returns that scheduled meal" do
        expect(schedule.meal_for(schedule.start_date, scheduled_meal.meal_type.id)).to eq(scheduled_meal)
      end
    end
    context "for a period that does not have a meal scheduled" do
      it "returns nil" do
        expect(schedule.meal_for(schedule.start_date + 1.day, scheduled_meal.meal_type.id)).to be_nil
      end
    end
  end
end
