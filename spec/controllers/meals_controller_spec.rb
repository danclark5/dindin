require 'rails_helper'
require 'pry'

RSpec.describe MealsController, type: :controller do

  let(:valid_attributes) { {name: "Chicken"} }

  let(:invalid_attributes) { {name: ""} }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MealsController. Be sure to keep this updated too.
  #
  # Dan's note: We'll revisit this in the future.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Meal.create! valid_attributes
      #get :index, params: {}, session: valid_session
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      meal = Meal.create! valid_attributes
      get :show, params: {id: meal.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      meal = Meal.create! valid_attributes
      get :edit, params: {id: meal.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Meal" do
        expect {
          post :create, params: {meal: valid_attributes}, session: valid_session
        }.to change(Meal, :count).by(1)
      end

      it "redirects to the created meal" do
        post :create, params: {meal: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Meal.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {meal: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {name: "Beef"} }

      it "updates the requested meal" do
        meal = Meal.create! valid_attributes
        put :update, params: {id: meal.to_param, meal: new_attributes}, session: valid_session
        meal.reload
        expect(meal.name).to eq( "Beef" )
      end

      it "redirects to the meal" do
        meal = Meal.create! valid_attributes
        put :update, params: {id: meal.to_param, meal: valid_attributes}, session: valid_session
        expect(response).to redirect_to(meal)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        meal = Meal.create! valid_attributes
        put :update, params: {id: meal.to_param, meal: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested meal" do
      meal = Meal.create! valid_attributes
      expect {
        delete :destroy, params: {id: meal.to_param}, session: valid_session
      }.to change(Meal, :count).by(-1)
    end

    it "redirects to the meals list" do
      meal = Meal.create! valid_attributes
      delete :destroy, params: {id: meal.to_param}, session: valid_session
      expect(response).to redirect_to(meals_url)
    end
  end

end
