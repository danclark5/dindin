require 'rails_helper'

RSpec.feature "Landing page meal suggestions", type: :feature, js: true do
  scenario "User clicks wants a different meal suggestion" do
    user = create(:user)
    sign_in user
    create(:meal, name: 'Hot Dogs')
    create(:meal, name: 'Stone Soup')
    create(:meal, name: 'Mac and Cheese')
    create(:meal, name: 'Salad')
    today = DateTime.current.strftime("%Y-%m-%d")

    visit "/"
    sleep 0.01
    suggested_meal = find("#scheduled_meal_#{today}_suggestion").find('a').text
    click_link "scheduled_meal_#{today}_new_suggestion"
    new_suggested_meal = find("#scheduled_meal_#{today}_suggestion").find('a').text
    expect(new_suggested_meal).not_to eq suggested_meal
  end
end
