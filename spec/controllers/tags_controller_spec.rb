require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:valid_attributes) { {name: "Chicken"} }
  let(:invalid_attributes) { {name: ""} }
  login_admin

  context "Logged in a non-admin" do
    login_free_user
    it "redirects for index" do
      get :index, params: {}
      expect(response).to redirect_to(root_path)
    end

    it "redirects for new" do
      get :new, params: {}
      expect(response).to redirect_to(root_path)
    end
  end
  
  describe "GET #index" do
    it "returns a success response" do
      create(:tag)
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Tag" do
        expect {
          post :create, params: {tag: valid_attributes}
        }.to change(Tag, :count).by(1)
      end

      it "redirects to the tag index" do
        post :create, params: {tag: valid_attributes}
        expect(response).to redirect_to(Tag)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {tag: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      tag = create(:tag)
      get :edit, params: {id: tag.id}
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {name: "Beef"} }

      it "updates the requested tag" do
        tag = Tag.create! valid_attributes
        put :update, params: {id: tag.to_param, tag: new_attributes}
        tag.reload
        expect(tag.name).to eq( "Beef" )
      end

      it "redirects to the tag" do
        tag = Tag.create! valid_attributes
        put :update, params: {id: tag.to_param, tag: valid_attributes}
        expect(response).to redirect_to(Tag)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        tag = Tag.create! valid_attributes
        put :update, params: {id: tag.to_param, tag: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end
  describe "DELETE #destroy" do
    it "destroys the requested tag" do
      tag = Tag.create! valid_attributes
      expect {
        delete :destroy, params: {id: tag.to_param}
      }.to change(Tag, :count).by(-1)
    end

    it "redirects to the tags list" do
      tag = Tag.create! valid_attributes
      delete :destroy, params: {id: tag.to_param}
      expect(response).to redirect_to(tags_url)
    end
  end
end
