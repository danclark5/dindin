require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe ".meals_for" do
    context "the user has no owned meals" do
      # TODO: this is wrong I think. It's creating users with meals. See ingredients.
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
