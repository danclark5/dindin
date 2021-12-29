require 'rails_helper'

RSpec.describe "ShoppingLists", type: :request do

  describe "GET /show" do
    before do
      user = create(:user)
      sign_in user
    end

    it "returns http success" do
      get "/shopping_list/show"
      expect(response).to have_http_status(:success)
    end
  end
end
