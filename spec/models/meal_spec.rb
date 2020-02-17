require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe ".get_suggested_meals" do
    before do
      create_list(:meal, 10)
    end
    context "7 meals are requested" do
      it "returns 7 unique meals" do
        expect(Meal.get_suggested_meals(7).uniq.length).to eq(7)
      end
    end
    context "0 meals are requested" do
      it "returns an empty array" do
        expect(Meal.get_suggested_meals(0)).to match_array([])
      end
    end
  end

  describe ".user_meals" do
    let(:user_meals) { create_list(:user_with_meal, 2) }
    let(:user) { user_meals.first }
    before do
      create(:meal)
    end
    it "returns meals that belong to that user or global meals" do
      expect(Meal.meals_for(user).length).to eq (2)
    end
  end
end
