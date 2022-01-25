require 'rails_helper'
require_relative '../../lib/meal_schedule.rb'

describe MealSchedule do
  before do
    @user = create(:user)
    @meal_names = %w(Hot\ Dogs Fried\ Chicken Spaghetti Extra\ Meal)
  end

  describe '#upcoming_scheduled_meals' do
    context 'there are meals scheduled for the user' do
      context 'all days are scheduled with a meal' do
        it 'returns the meals for the date range specified, all days have a meal' do
          scheduled_meals = create_list(:scheduled_meal, 3, user: @user) do |scheduled_meal, i|
            scheduled_meal.date = Date.today + i
            scheduled_meal.save
          end

          schedule = MealSchedule.new(days: 3, user: @user)
          expect(schedule.upcoming_scheduled_meals).to eq scheduled_meals
        end
      end

      context 'first and third days are scheduled with a meal, no meal on the second day' do
        it 'returns the meals for the date range specified' do
          scheduled_meals = create_list(:scheduled_meal, 2, user: @user) do |scheduled_meal, i|
            scheduled_meal.date = Date.today + (i * 2)
            scheduled_meal.save
          end

          schedule = MealSchedule.new(days: 3, user: @user)
          expect(schedule.upcoming_scheduled_meals).to eq scheduled_meals
        end
      end
    end

    context 'there are no meals scheduled for the user' do
      it 'returns an array with no meals attached' do
        schedule = MealSchedule.new(days: 3, user: @user)
        expect(schedule.upcoming_scheduled_meals).to eq []
      end
    end
  end

  describe "#suggest_meals" do
    before do
      create_list(:meal, 10)
    end
    context "7 meals are requested" do
      it "returns 7 unique meals" do
        schedule = MealSchedule.new(days: 1, user: @user)
        expect(schedule.suggest_meals(7).uniq.length).to eq(7)
      end

      it "stores the suggestions" do
        MealSchedule.new(days: 1, user: @user).suggest_meals(7)
        expect(MealSuggestionLog.count). to eq(7)
      end
    end

    context "0 meals are requested" do
      it "returns an empty array" do
        schedule = MealSchedule.new(days: 1, user: @user)
        expect(schedule.suggest_meals(0)).to match_array([])
      end

      it "does not store the suggestions" do
        MealSchedule.new(days: 1, user: @user).suggest_meals(0)
        expect(MealSuggestionLog.count). to eq(0)
      end
    end

    it 'raises an exception if not given a number of meals' do
      schedule = MealSchedule.new(days: 1, user: @user)
      expect { schedule.suggest_meals }.to raise_error(ArgumentError)
    end
  end

  describe '#generate' do
    before do
        @expected_meal_ids = []
        @meals = create_list(:meal, 5) do |meal, i|
          meal.name = @meal_names[i]
        end
    end

    it 'returns an array with an element for each date' do
      expected_dates = (Date.today..4.days.from_now.to_date).to_a

      schedule = MealSchedule.new(days: 5, user: @user).generate
      expect(schedule.map { |m| m.date }).to eq(expected_dates)
    end

    it 'returns an empty set if asked for 0 meals' do
      schedule = MealSchedule.new(days: 0, user: @user).generate
      expect(schedule).to eq []
    end

    context 'there are meals scheduled' do
      it 'returns all requested meals' do
        scheduled_meals = create_list(:scheduled_meal, 3, user: @user) do |scheduled_meal, i|
          scheduled_meal.date = Date.today + i
          scheduled_meal.save
          scheduled_meal.meal.name = @meal_names[i]
          scheduled_meal.meal.save
        end

        meals_scheduled = MealSchedule.new(days: 3, user: @user).generate.map { |um| um.meal.meal.name }
        expect(meals_scheduled).to eq(@meal_names.slice(0, 3))
      end

      it 'returns only scheduled meals' do
        scheduled_meals = create_list(:scheduled_meal, 3, user: @user) do |scheduled_meal, i|
          scheduled_meal.date = Date.today + i
          scheduled_meal.save
          scheduled_meal.meal.name = @meal_names[i]
          scheduled_meal.meal.save
        end

        schedule = MealSchedule.new(days: 3, user: @user).generate
        expect(schedule.map { |um| um.meal}).to all(be_a(ScheduledMeal))
      end
    end

    context 'there are no meals scheduled' do
      it 'returns all the requested meals' do
        schedule = MealSchedule.new(days: 3, user: @user).generate
        expect(schedule.count).to eq(3)
      end

      it 'returns only suggested meals' do
        schedule = MealSchedule.new(days: 3, user: @user).generate
        expect(schedule.map(&:suggestions).flatten).to all(be_a(Meal))
      end
    end

    context 'some meals are scheduled' do
      before do
        @expected_meal_ids << create(:scheduled_meal, user: @user, meal: @meals[0]).id
        @expected_meal_ids << create(:scheduled_meal, user: @user, meal: @meals[2], date: Date.today + 2).id
      end

      it 'returns the scheduled meals' do
        schedule = MealSchedule.new(days: 3, user: @user).generate
        expect(schedule.first.meal.id).to eq(@expected_meal_ids[0])
        expect(schedule.last.meal.id).to eq(@expected_meal_ids[1])
      end

      it 'returns the suggested meals' do
        schedule = MealSchedule.new(days: 3, user: @user).generate
        expect(schedule[1].suggestions).to all(be_a(Meal))
      end
    end

    context 'too many meals are scheduled' do
      # This is an error edge case where more than one meal was scheduled for a
      # day. Getting to this point means something has gone wrong, but we'd
      # liked to account for it.
      context 'all days have a scheduled meal' do
        before do
          scheduled_meals = create_list(:scheduled_meal, 3, user: @user) do |scheduled_meal, i|
            scheduled_meal.date = Date.today + i
            scheduled_meal.save
            scheduled_meal.meal.name = @meal_names[i]
            scheduled_meal.meal.save
          end

          extra_scheduled_meal = create(:scheduled_meal, user: @user, date: Date.today + 2)
          extra_scheduled_meal.meal.name = @meal_names[3]
          extra_scheduled_meal.save

          scheduled_meals << extra_scheduled_meal
        end

        it 'returns a schedule with 4 meals for 3 days' do
          schedule = MealSchedule.new(days: 3, user: @user).generate
          expect(schedule.count).to eq(4)
        end

        it 'returns a schedule with only ScheduledMeals' do
          schedule = MealSchedule.new(days: 3, user: @user).generate
          expect(schedule.map(&:meal)).to all(be_a(ScheduledMeal))
        end

        it 'will not attempt to suggest meals' do
          schedule = MealSchedule.new(days: 3, user: @user)
          expect(schedule).not_to receive(:suggest_meals)
          schedule.generate
        end
      end

      context 'some days are missing a scheduled meal' do
        before do
          scheduled_meals = create_list(:scheduled_meal, 2, user: @user) do |scheduled_meal, i|
            scheduled_meal.date = Date.today
            scheduled_meal.save
            scheduled_meal.meal.name = @meal_names[i]
            scheduled_meal.meal.save
          end

          scheduled_meal = create(:scheduled_meal, user: @user, date: Date.today + 2)
          scheduled_meal.meal.name = @meal_names[3]
          scheduled_meal.save

          scheduled_meals << scheduled_meal
        end

        it 'returns a schedule with 4 meals for 3 days' do
          schedule = MealSchedule.new(days: 3, user: @user).generate
          expect(schedule.count).to eq(4)
        end

        it 'returns a schedule with a suggested meal on the second day' do
          schedule = MealSchedule.new(days: 3, user: @user).generate
          expect(schedule[2].suggestions).to all(be_a(Meal))
        end

        it 'returns the schedule in chronological order' do
          schedule_dates = MealSchedule.new(days: 3, user: @user).generate.map(&:date)
          expect(schedule_dates).to eq(schedule_dates.sort)
        end
      end
    end
  end
end
