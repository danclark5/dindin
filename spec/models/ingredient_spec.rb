require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe ".ingredients_for" do
    context "the user has no owned ingredients" do
      let!(:user) { create(:user) }
      let!(:other_user) { create(:user) }
      let!(:other_user_ingredients) { create_list(:ingredient, 10, user: other_user) }
      before do
        create_list(:ingredient, 10)
      end
      it "returns only the global ingredients" do
        expect(Ingredient.ingredients_for(user).length).to eq (10)
      end
    end
    
    context "the user owns an ingredient" do
      let!(:user) { create(:user) }
      let!(:user_ingredients) { create_list(:ingredient, 10, user: user) }
      let!(:other_user) { create(:user) }
      let!(:other_user_ingredients) { create_list(:ingredient, 10, user: other_user) }
      before do
        create_list(:ingredient, 10)
      end
      it "returns the user-owned and global ingredients" do
        expect(Ingredient.ingredients_for(user).length).to eq (20)
      end
    end
  end
end
