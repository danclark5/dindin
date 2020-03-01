require 'rails_helper'

RSpec.describe "scheduled_meals/show", type: :view do
  before do
    user = create(:user)
    sign_in user

    assign(:scheduled_meal, create(:scheduled_meal, meal: create(:meal, name: "Hot Dogs"), user: user))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Hot Dogs/)
  end
end
