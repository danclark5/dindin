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
    tomorrow = (DateTime.current + 1).strftime("%Y-%m-%d")
    day_after = (DateTime.current + 2).strftime("%Y-%m-%d")

    visit "/"
    sleep 0.01
    suggested_meal_1 = find("#scheduled_meal_#{today}_suggestion_link").find('a').text
    suggested_meal_2 = find("#scheduled_meal_#{tomorrow}_suggestion_link").find('a').text
    suggested_meal_3 = find("#scheduled_meal_#{day_after}_suggestion_link").find('a').text
    click_link "scheduled_meal_#{today}_new_suggestion"
    sleep 0.5
    new_suggested_meal_1 = find("#scheduled_meal_#{today}_suggestion_link").find('a').text
    new_suggested_meal_2 = find("#scheduled_meal_#{tomorrow}_suggestion_link").find('a').text
    new_suggested_meal_3 = find("#scheduled_meal_#{day_after}_suggestion_link").find('a').text
    expect(new_suggested_meal_1).not_to eq suggested_meal_1
    expect(new_suggested_meal_2).to eq suggested_meal_2
    expect(new_suggested_meal_3).to eq suggested_meal_3
  end
end
