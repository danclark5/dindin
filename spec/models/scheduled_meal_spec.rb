require 'rails_helper'

describe ScheduledMeal, type: :model do
  before { @user = create(:user) }

  describe '#swap_meal' do
    it 'swaps the dates' do
      todays_scheduled_meal = create(:scheduled_meal, user: @user, date: Date.today)
      tomorrows_scheduled_meal = create(:scheduled_meal, user: @user, date: Date.tomorrow)

      todays_scheduled_meal.swap_meal(tomorrows_scheduled_meal)

      expect(todays_scheduled_meal.date).to eq(Date.tomorrow)
      expect(tomorrows_scheduled_meal.date).to eq(Date.today)
    end

    context 'the owning users do not match' do
      it 'raises an error' do
      other_user = create(:user)
      todays_scheduled_meal = create(:scheduled_meal, user: @user, date: Date.today)
      tomorrows_scheduled_meal = create(:scheduled_meal, user: other_user, date: Date.tomorrow)

      expect { todays_scheduled_meal.swap_meal(tomorrows_scheduled_meal) }.to raise_error MealSwapProhibited
      end
    end
  end
end
