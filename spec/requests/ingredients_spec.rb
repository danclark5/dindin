 require 'rails_helper'

RSpec.describe "/ingredients", type: :request do
  let(:valid_attributes) { { name: 'Garlic' ) }
  let(:invalid_attributes) { { name: nil } }

  describe "GET /index" do
    before do
      create(:ingredient)
    end

    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        get ingredients_url
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      it "renders a successful response" do
        get ingredients_url
        expect(response).to be_successful
      end
    end
  end

  describe "GET /show" do
    let(:ingredient) { create(:ingredient) }

    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        get ingredients_url
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      it "renders a successful response" do
        get ingredient_url(ingredient)
        expect(response).to be_successful
      end
    end
  end

  describe "GET /new" do
    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        get new_ingredient_url
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      it "renders a successful response" do
        get new_ingredient_url
        expect(response).to be_successful
      end
    end
  end

  describe "GET /edit" do
    let (:ingredient) { create(:ingredient) }

    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        get edit_ingredient_url(ingredient)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      it "render a successful response" do
        get edit_ingredient_url(ingredient)
        expect(response).to be_successful
      end
    end
  end

  describe "POST /create" do
    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        post ingredients_url, params: { ingredient: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin user' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      context "with valid parameters" do
        it "creates a new Ingredient" do
          expect {
            post ingredients_url, params: { ingredient: valid_attributes }
          }.to change(Ingredient, :count).by(1)
        end

        it "redirects to the created ingredient" do
          post ingredients_url, params: { ingredient: valid_attributes }
          expect(response).to redirect_to(ingredient_url(Ingredient.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Ingredient" do
          expect {
            post ingredients_url, params: { ingredient: invalid_attributes }
          }.to change(Ingredient, :count).by(0)
        end

        it "renders a successful response (i.e. to display the 'new' template)" do
          post ingredients_url, params: { ingredient: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end
  end

  describe "PATCH /update" do
    let(:ingredient) { create(:ingredient) }
    let(:new_attributes) { {name: "Onion"} }

    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        patch ingredient_url(ingredient), params: { ingredient: new_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is a admin user' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      context "with valid parameters" do

        it "updates the requested ingredient" do
          patch ingredient_url(ingredient), params: { ingredient: new_attributes }
          ingredient.reload
          expect(ingredient.name).to eq("Onion")
        end

        it "redirects to the ingredient" do
          patch ingredient_url(ingredient), params: { ingredient: new_attributes }
          ingredient.reload
          expect(response).to redirect_to(ingredient_url(ingredient))
        end
      end

      context "with invalid parameters" do
        it "renders a successful response (i.e. to display the 'edit' template)" do
          patch ingredient_url(ingredient), params: { ingredient: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:ingredient) { create(:ingredient) }

    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        delete ingredient_url(ingredient)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin user' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      it "destroys the requested ingredient" do
        expect {
          delete ingredient_url(ingredient)
        }.to change(Ingredient, :count).by(-1)
      end

      it "redirects to the ingredients list" do
        delete ingredient_url(ingredient)
        expect(response).to redirect_to(ingredients_url)
      end
    end
  end
end
