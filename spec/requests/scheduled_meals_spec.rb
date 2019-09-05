require 'rails_helper'

RSpec.describe "ScheduledMeals", type: :request do
  describe "GET /scheduled_meals" do
    it "works! (now write some real specs)" do
      get scheduled_meals_path
      expect(response).to have_http_status(200)
    end
  end
end
