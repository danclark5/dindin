require 'rails_helper'

RSpec.describe SchedulesController, type: :controller do

  let(:valid_attributes) {
    { start_date: Time.now,
      end_date: Time.now,
      include_breakfast: true,
      include_lunch: true,
      include_dinner: true,
      default_participant_count: 4}
  }

  let(:invalid_attributes) {
    { start_date: 10,
      end_date: "something",
      include_breakfast: "went",
      include_lunch: "wrong",
      include_dinner: true,
      default_participant_count: "a lot"}
  }
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      Schedule.create! valid_attributes
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      schedule = Schedule.create! valid_attributes
      get :show, params: {id: schedule.to_param}, session: valid_session
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
      schedule = Schedule.create! valid_attributes
      get :edit, params: {id: schedule.to_param}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Scheduled" do
        expect {
          post :create, params: {schedule: valid_attributes}, session: valid_session
        }.to change(Schedule, :count).by(1)
      end

      it "redirects to the created schedule" do
        post :create, params: {schedule: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Schedule.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {schedule: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { start_date: Time.now,
          end_date: Time.now,
          include_breakfast: true,
          include_lunch: true,
          include_dinner: true,
          default_participant_count: 5}
      }

      it "updates the requested schedule" do
        schedule = Schedule.create! valid_attributes
        put :update, params: {id: schedule.to_param, schedule: new_attributes}, session: valid_session
        schedule.reload
        expect(schedule[:default_participant_count]).to eq(5)
      end

      it "redirects to the schedule" do
        schedule = Schedule.create! valid_attributes
        put :update, params: {id: schedule.to_param, schedule: valid_attributes}, session: valid_session
        expect(response).to redirect_to(schedule)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        schedule = Schedule.create! valid_attributes
        put :update, params: {id: schedule.to_param, schedule: invalid_attributes}, session: valid_session
        expect(response).to be_successful
      end
    end
  end
end
