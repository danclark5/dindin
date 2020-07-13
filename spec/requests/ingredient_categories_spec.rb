 require 'rails_helper'

RSpec.describe "/ingredient_categories", type: :request do
  let(:valid_attributes) { { name: 'Produce' } }
  let(:invalid_attributes) { { name: nil } }

  describe "GET /index" do
    before do
      create(:ingredient_category)
    end

    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "renders a successful response" do
        get ingredient_categories_url
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      it "renders a successful response" do
        get ingredient_categories_url
        expect(response).to be_successful
      end
    end
  end

  describe "GET /show" do
    let(:ingredient_category) { create(:ingredient_category) }

    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        get ingredient_category_url(ingredient_category)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      it "renders a successful response" do
        get ingredient_category_url(ingredient_category)
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
        get new_ingredient_category_url
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      it "renders a successful response" do
        get new_ingredient_category_url
        expect(response).to be_successful
      end
    end
  end

  describe "GET /edit" do
    let (:ingredient_category) { create(:ingredient_category) }

    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        get edit_ingredient_category_url(ingredient_category)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is a admin user' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      it "render a successful response" do
        get edit_ingredient_category_url(ingredient_category)
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
        post ingredient_categories_url, params: { ingredient_category: valid_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin user' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      context "with valid parameters" do
        it "creates a new IngredientCategory" do
          expect {
            post ingredient_categories_url, params: { ingredient_category: valid_attributes }
          }.to change(IngredientCategory, :count).by(1)
        end

        it "redirects to the created ingredient_category" do
          post ingredient_categories_url, params: { ingredient_category: valid_attributes }
          expect(response).to redirect_to(ingredient_category_url(IngredientCategory.last))
        end
      end

      context "with invalid parameters" do
        it "does not create a new IngredientCategory" do
          expect {
            post ingredient_categories_url, params: { ingredient_category: invalid_attributes }
          }.to change(IngredientCategory, :count).by(0)
        end

        it "renders a successful response (i.e. to display the 'new' template)" do
          post ingredient_categories_url, params: { ingredient_category: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end
  end

  describe "PATCH /update" do
    let(:ingredient_category) { create(:ingredient_category) }
    let(:new_attributes) { {name: "Fish"} }

    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        patch ingredient_category_url(ingredient_category), params: { ingredient_category: new_attributes }
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is a admin user' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      context "with valid parameters" do
        it "updates the requested ingredient_category" do
          patch ingredient_category_url(ingredient_category), params: { ingredient_category: new_attributes }
          ingredient_category.reload
          expect(ingredient_category.name).to eq("Fish")
        end

        it "redirects to the ingredient_category" do
          patch ingredient_category_url(ingredient_category), params: { ingredient_category: new_attributes }
          ingredient_category.reload
          expect(response).to redirect_to(ingredient_category_url(ingredient_category))
        end
      end

      context "with invalid parameters" do
        it "renders a successful response (i.e. to display the 'edit' template)" do
          patch ingredient_category_url(ingredient_category), params: { ingredient_category: invalid_attributes }
          expect(response).to be_successful
        end
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:ingredient_category) { create(:ingredient_category) }

    context 'is a free user' do
      before do
        user = create(:user)
        sign_in user
      end

      it "redirects to the landing page" do
        delete ingredient_category_url(ingredient_category)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'is an admin user' do
      before do
        user = create(:user, :admin)
        sign_in user
      end

      it "destroys the requested ingredient_category" do
        expect {
          delete ingredient_category_url(ingredient_category)
        }.to change(IngredientCategory, :count).by(-1)
      end

      it "redirects to the ingredient_categories list" do
        delete ingredient_category_url(ingredient_category)
        expect(response).to redirect_to(ingredient_categories_url)
      end
    end
  end
end
