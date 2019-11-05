require 'rails_helper'

RSpec.describe Schedule, type: :model do

  subject(:schedule) { build(:schedule) }

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
end
