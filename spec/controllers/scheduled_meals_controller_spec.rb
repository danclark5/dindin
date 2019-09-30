require 'rails_helper'

RSpec.describe ScheduledMealsController, type: :controller do

  let(:valid_attributes) {
    {
      date: Time.now,
      meal_id: meal.id,
      meal_type_id: meal_type.id,
      schedule_id: schedule.id
    }
  }

  let(:invalid_attributes) {
    {
      date: "Maybe",
      meal_id: "No",
      meal_type_id: "nope",
      schedule_id: "" 
    }
  }

  let(:valid_session) { {} }
  let(:meal_type) { build(:meal_type) }
  let(:meal) { build(:meal) }
  let(:schedule) { build(:schedule) }

  describe "GET #index" do
    it "returns a success response" do
      #TODO: This is where I left off on 9/30 it's failing on the route as the id is not present on ScheduledMeal
      scheduled_meal = create(:scheduled_meal)
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      scheduled_meal = build(:scheduled_meal)
      get :show, params: {id: scheduled_meal.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      scheduled_meal = ScheduledMeal.create! valid_attributes
      get :edit, params: {id: scheduled_meal.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ScheduledMeal" do
        expect {
          post :create, params: {scheduled_meal: valid_attributes}, session: valid_session
        }.to change(ScheduledMeal, :count).by(1)
      end

      it "redirects to the created scheduled_meal" do
        post :create, params: {scheduled_meal: valid_attributes}, session: valid_session
        expect(response).to redirect_to(ScheduledMeal.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {scheduled_meal: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested scheduled_meal" do
        scheduled_meal = ScheduledMeal.create! valid_attributes
        put :update, params: {id: scheduled_meal.to_param, scheduled_meal: new_attributes}, session: valid_session
        scheduled_meal.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the scheduled_meal" do
        scheduled_meal = ScheduledMeal.create! valid_attributes
        put :update, params: {id: scheduled_meal.to_param, scheduled_meal: valid_attributes}, session: valid_session
        expect(response).to redirect_to(scheduled_meal)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        scheduled_meal = ScheduledMeal.create! valid_attributes
        put :update, params: {id: scheduled_meal.to_param, scheduled_meal: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested scheduled_meal" do
      scheduled_meal = ScheduledMeal.create! valid_attributes
      expect {
        delete :destroy, params: {id: scheduled_meal.to_param}, session: valid_session
      }.to change(ScheduledMeal, :count).by(-1)
    end

    it "redirects to the scheduled_meals list" do
      scheduled_meal = ScheduledMeal.create! valid_attributes
      delete :destroy, params: {id: scheduled_meal.to_param}, session: valid_session
      expect(response).to redirect_to(scheduled_meals_url)
    end
  end

end
