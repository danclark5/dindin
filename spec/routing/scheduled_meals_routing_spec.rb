require "rails_helper"

RSpec.describe ScheduledMealsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/scheduled_meals").to route_to("scheduled_meals#index")
    end

    it "routes to #new" do
      expect(:get => "/scheduled_meals/new").to route_to("scheduled_meals#new")
    end

    it "routes to #show" do
      expect(:get => "/scheduled_meals/1").to route_to("scheduled_meals#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/scheduled_meals/1/edit").to route_to("scheduled_meals#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/scheduled_meals").to route_to("scheduled_meals#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/scheduled_meals/1").to route_to("scheduled_meals#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/scheduled_meals/1").to route_to("scheduled_meals#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/scheduled_meals/1").to route_to("scheduled_meals#destroy", :id => "1")
    end
  end
end
