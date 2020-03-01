require 'rails_helper'

RSpec.describe MealsController, type: :controller do

  let(:valid_attributes) { {name: "Chicken"} }
  let(:valid_attributes_with_global) { {name: "Chicken", global_meal: '1'} }
  let(:invalid_attributes) { {name: ""} }
  login_free_user

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # MealsController. Be sure to keep this updated too.
  #
  # Dan's note: We'll revisit this in the future.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      create(:meal)
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    context "when viewing a global meal" do
      it "returns a success response" do
        meal = create(:meal)
        get :show, params: {id: meal.id}
        expect(response).to be_successful
      end
    end

    context "when viewing a user created meal" do
      it "returns a success response" do
        meal = create(:meal, user: controller.current_user)
        get :show, params: {id: meal.id}
        expect(response).to be_successful
      end
    end

    context "when viewing another user's meal" do
      let(:other_user) { create(:user_with_meal) }
      it "redirects with an error" do
        get :show, params: {id: other_user.meals.first.id}
        expect(response).to redirect_to(Meal)
        expect(response.request.env['rack.session']['flash']['flashes']['alert']).to eq('Meal not found')
      end
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "as an admin" do
      login_admin
      context "with valid params" do
        it "creates a new Meal" do
          expect {
            post :create, params: {meal: valid_attributes_with_global}
          }.to change(Meal, :count).by(1)
        end

        it "redirects to the created meal" do
          post :create, params: {meal: valid_attributes_with_global}
          expect(response).to redirect_to(Meal.last)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {meal: invalid_attributes}
          expect(response).to be_successful
        end
      end
    end

    context "as a free user" do
      context "with valid params" do
        it "creates a new Meal" do
          expect {
            post :create, params: {meal: valid_attributes}
          }.to change(Meal, :count).by(1)
        end

        it "redirects to the created meal" do
          post :create, params: {meal: valid_attributes}
          expect(response).to redirect_to(Meal.last)
        end
      end

      context "with valid params and global_meal" do
        it "creates a new Meal" do
          expect {
            post :create, params: {meal: valid_attributes_with_global}
          }.to change(Meal, :count).by(1)
        end

        it "redirects to the created meal" do
          post :create, params: {meal: valid_attributes_with_global}
          expect(response).to redirect_to(Meal.last)
        end
        
        it "does sets the user attribute anyway" do
          post :create, params: {meal: valid_attributes_with_global}
          expect(Meal.last.user).to eq(controller.current_user)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          post :create, params: {meal: invalid_attributes}
          expect(response).to be_successful
        end
      end
    end
  end

  describe "GET #edit" do
    context "when viewing a global meal" do
      it "returns a success response" do
        meal = create(:meal)
        get :edit, params: {id: meal.id}
        expect(response).to be_successful
      end
    end

    context "when viewing a user created meal" do
      it "returns a success response" do
        meal = create(:meal, user: controller.current_user)
        get :edit, params: {id: meal.id}
        expect(response).to be_successful
      end
    end

    context "when viewing another user's meal" do
      let(:other_user) { create(:user_with_meal) }
      it "redirects with an error" do
        get :edit, params: {id: other_user.meals.first.id}
        expect(response).to redirect_to(Meal)
        expect(response.request.env['rack.session']['flash']['flashes']['alert']).to eq('Meal not found')
      end
    end
  end

  describe "PUT #update" do
    context "as an admin" do
      login_admin
      context "with valid params" do
        let(:new_attributes) { {name: "Beef"} }

        it "updates the requested meal" do
          meal = Meal.create! valid_attributes
          put :update, params: {id: meal.to_param, meal: new_attributes}
          meal.reload
          expect(meal.name).to eq( "Beef" )
        end

        it "redirects to the meal" do
          meal = Meal.create! valid_attributes
          put :update, params: {id: meal.to_param, meal: valid_attributes}
          expect(response).to redirect_to(meal)
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          meal = Meal.create! valid_attributes
          put :update, params: {id: meal.to_param, meal: invalid_attributes}
          expect(response).to be_successful
        end
      end
    end

    context "as a free user" do
      login_free_user
      context "with valid params" do
        let(:new_attributes) { {name: "Beef"} }

        it "updates the requested meal" do
          meal = create(:meal, user: controller.current_user)
          put :update, params: {id: meal.to_param, meal: new_attributes}
          meal.reload
          expect(meal.name).to eq( "Beef" )
        end

        it "redirects to the meal" do
          meal = create(:meal, user: controller.current_user)
          put :update, params: {id: meal.to_param, meal: valid_attributes}
          expect(response).to redirect_to(meal)
        end

        it "doesn't update global meals" do
          meal = create(:meal)
          put :update, params: {id: meal.id, meal: new_attributes}
          meal.reload
          expect(meal.name).not_to eq( "Beef" )
        end

        it "doesn't update other user meals" do
          other_user = create(:user_with_meal)
          meal = other_user.meals.first
          put :update, params: {id: meal.id, meal: new_attributes}
          meal.reload
          expect(meal.name).not_to eq( "Beef" )
        end
      end

      context "with valid params and global_meal" do
        let(:new_attributes) { {name: "Beef", global_meal: "1"} }
        it "updates the meal" do
          meal = create(:meal, user: controller.current_user)
          put :update, params: {id: meal.to_param, meal: new_attributes}
          meal.reload
          expect(meal.name).to eq( "Beef" )
        end

        it "redirects to the updated meal" do
          meal = create(:meal, user: controller.current_user)
          put :update, params: {id: meal.to_param, meal: valid_attributes}
          expect(response).to redirect_to(meal)
        end
        
        it "does sets the user attribute anyway" do
          meal = create(:meal, user: controller.current_user)
          put :update, params: {id: meal.to_param, meal: new_attributes}
          meal.reload
          expect(meal.user).to eq( controller.current_user )
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'new' template)" do
          meal = create(:meal, user: controller.current_user)
          put :update, params: {id: meal.to_param, meal: invalid_attributes}
          expect(response).to be_successful
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "as an admin" do
      login_admin
      it "destroys the requested meal" do
        meal = Meal.create! valid_attributes
        expect {
          delete :destroy, params: {id: meal.to_param}
        }.to change(Meal, :count).by(-1)
      end

      it "redirects to the meals list" do
        meal = Meal.create! valid_attributes
        delete :destroy, params: {id: meal.to_param}
        expect(response).to redirect_to(meals_url)
      end
    end

    context "as a free user" do
      login_free_user
      it "destroys the user's meals" do
          meal = create(:meal, user: controller.current_user)
          expect {
            delete :destroy, params: {id: meal.id}
          }.to change(Meal, :count).by(-1)
      end

      it "redirects to index after a successfuly destroy" do
        meal = Meal.create! valid_attributes
        delete :destroy, params: {id: meal.id}
        expect(response).to redirect_to(meals_path)
      end

      it "doesn't destroy global meals" do
          meal = create(:meal)
          delete :destroy, params: {id: meal.id}
          expect(Meal.exists?(meal.id)).to be_truthy
      end

      it "doesn't destroy other user's meals" do
          other_user = create(:user_with_meal)
          meal = other_user.meals.first
          delete :destroy, params: {id: meal.id}
          expect(Meal.exists?(meal.id)).to be_truthy 
      end

      it "redirects to the index after an unsuccessful destroy" do
        meal = create(:meal)
        delete :destroy, params: {id: meal.id}
        expect(response).to redirect_to(meals_url)
      end

    end
  end
end
