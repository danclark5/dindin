require 'rails_helper'

RSpec.describe "meals/index", type: :view do
  before(:each) do
    assign(:meals, [
      Meal.create!(
        :name => "Name"
      ),
      Meal.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of meals" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
