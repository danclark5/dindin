require 'rails_helper'

RSpec.describe ScheduledMealsController, type: :controller do
  login_user

  let(:meal) { create(:meal) }
  let(:schedule) { create(:schedule) }

  let(:valid_attributes) {
    {
      date: Time.now,
      meal_id: meal.id,
      schedule_id: schedule.id
    }
  }

  let(:invalid_attributes) {
    {
      date: "Maybe",
      meal_id: "No",
      schedule_id: "" 
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      scheduled_meal = create(:scheduled_meal)
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      scheduled_meal = create(:scheduled_meal, user: subject.current_user)
      get :show, params: {id: scheduled_meal.to_param}
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
      scheduled_meal = create(:scheduled_meal, user: subject.current_user)
      get :edit, params: {id: scheduled_meal.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new ScheduledMeal" do
        expect {
          post :create, params: {scheduled_meal: valid_attributes}
        }.to change(ScheduledMeal, :count).by(1)
      end

      it "redirects to the created scheduled_meal" do
        post :create, params: {scheduled_meal: valid_attributes}
        expect(response).to redirect_to(schedule)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {scheduled_meal: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:second_meal) { create(:meal, name: "second dinner") }
      let(:new_attributes) {{
        date: Time.now,
        meal_id: second_meal.id,
        schedule_id: schedule.id
      }}

      it "updates the requested scheduled_meal" do
        scheduled_meal = create(:scheduled_meal, user: subject.current_user)
        put :update, params: {id: scheduled_meal.to_param, scheduled_meal: new_attributes}
        scheduled_meal.reload
        expect(scheduled_meal.meal_id).to eq(second_meal.id)
      end

      it "redirects to the scheduled_meal" do
        scheduled_meal = create(:scheduled_meal, user: subject.current_user)
        put :update, params: {id: scheduled_meal.to_param, scheduled_meal: valid_attributes}
        expect(response).to redirect_to(schedule)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        scheduled_meal = ScheduledMeal.create! valid_attributes.merge({ user: subject.current_user })
        put :update, params: {id: scheduled_meal.to_param, scheduled_meal: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested scheduled_meal" do
      scheduled_meal = ScheduledMeal.create! valid_attributes.merge({ user: subject.current_user })
      expect {
        delete :destroy, params: {id: scheduled_meal.to_param}
      }.to change(ScheduledMeal, :count).by(-1)
    end

    it "redirects to the scheduled_meals list" do
      scheduled_meal = ScheduledMeal.create! valid_attributes.merge({ user: subject.current_user })
      delete :destroy, params: {id: scheduled_meal.to_param}
      expect(response).to redirect_to(scheduled_meals_url)
    end
  end

end
