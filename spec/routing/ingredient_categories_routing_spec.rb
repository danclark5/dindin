require "rails_helper"

RSpec.describe IngredientCategoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/ingredient_categories").to route_to("ingredient_categories#index")
    end

    it "routes to #new" do
      expect(get: "/ingredient_categories/new").to route_to("ingredient_categories#new")
    end

    it "routes to #show" do
      expect(get: "/ingredient_categories/1").to route_to("ingredient_categories#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/ingredient_categories/1/edit").to route_to("ingredient_categories#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/ingredient_categories").to route_to("ingredient_categories#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/ingredient_categories/1").to route_to("ingredient_categories#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/ingredient_categories/1").to route_to("ingredient_categories#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/ingredient_categories/1").to route_to("ingredient_categories#destroy", id: "1")
    end
  end
end
