require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe ".get_suggested_meals" do
    let(:user) { create(:user) }
    before do
      create_list(:meal, 10)
    end
    context "7 meals are requested" do
      it "returns 7 unique meals" do
        expect(Meal.get_suggested_meals(7, user).uniq.length).to eq(7)
      end

      it "stores the suggestions" do
        puts "user_id: #{user.id}"
        Meal.get_suggested_meals(7, user)
        expect(MealSuggestionLog.count). to eq(7)
      end
    end
    context "0 meals are requested" do
      it "returns an empty array" do
        expect(Meal.get_suggested_meals(0, user)).to match_array([])
      end

      it "does not store the suggestions" do
        Meal.get_suggested_meals(0, user)
        expect(MealSuggestionLog.count). to eq(0)
      end
    end
  end

  describe ".user_meals" do
    context "the user has no owned meals" do
      let!(:user_meals) { create_list(:user_with_meal, 2) }
      let!(:user) { user_meals.first }
      it "returns meals that belong to that user or global meals" do
        expect(Meal.meals_for(user).length).to eq (1)
      end
    end

    context "there are user owned meals and global meals" do
      let!(:user_meals) { create_list(:user_with_meal, 2) }
      let!(:user) { user_meals.first }
      let!(:other_meal) { create(:meal) }
      it "returns meals that belong to that user or global meals" do
        expect(Meal.meals_for(user).length).to eq (2)
      end
    end
  end

  describe ".accessible_to_user?" do
    let(:user) { create(:user) }
    context "global meal" do
      let(:meal) { create(:meal) }
      it "returns true" do
        expect(meal.accessible_to_user?(user)).to be_truthy
      end
    end

    context "user owned meal" do
      let(:meal) { create(:meal, user: user) }
      it "returns true" do
        expect(meal.accessible_to_user?(user)).to be_truthy
      end
    end

    context "meal owned by another user" do
      let(:other_user) { create(:user) }
      let(:meal) { create(:meal, user: other_user) }
      it "returns false" do
        expect(meal.accessible_to_user?(user)).to be_falsey
      end
    end
  end
end
