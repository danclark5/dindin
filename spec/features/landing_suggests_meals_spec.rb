require 'rails_helper'

RSpec.feature "Landing page meal suggestions", type: :feature, js: true do
  scenario "User clicks wants a different meal suggestion" do
    user = create(:user)
    sign_in user
    meal_names = %w(Hot\ Dogs Fried\ Chicken Spaghetti Extra\ Meal Stone\ Soup Mac\ and\ Cheese Salad)
    create_list(:meal, 7) do |meal, i|
      meal.name = meal_names[i]
      meal.save
    end
    today = DateTime.current.strftime("%Y-%m-%d")
    tomorrow = (DateTime.current + 1).strftime("%Y-%m-%d")
    day_after = (DateTime.current + 2).strftime("%Y-%m-%d")

    visit "/"
    sleep 0.01
    suggested_meal_1 = find("#scheduled_meal_#{today}_suggestion_link_0").all('a')[1].text
    suggested_meal_2 = find("#scheduled_meal_#{tomorrow}_suggestion_link_0").all('a')[1].text
    suggested_meal_3 = find("#scheduled_meal_#{day_after}_suggestion_link_0").all('a')[1].text
    click_link "scheduled_meal_#{today}_new_suggestion"
    sleep 0.5
    new_suggested_meal_1a = find("#scheduled_meal_#{today}_suggestion_link_0").all('a')[1].text
    new_suggested_meal_1b = find("#scheduled_meal_#{today}_suggestion_link_1").all('a')[1].text
    new_suggested_meal_1c = find("#scheduled_meal_#{today}_suggestion_link_2").all('a')[1].text
    new_suggested_meal_2 = find("#scheduled_meal_#{tomorrow}_suggestion_link_0").all('a')[1].text
    new_suggested_meal_3 = find("#scheduled_meal_#{day_after}_suggestion_link_0").all('a')[1].text
    expect(new_suggested_meal_1a).not_to eq suggested_meal_1
    expect(new_suggested_meal_1b).not_to eq suggested_meal_1
    expect(new_suggested_meal_1c).not_to eq suggested_meal_1
    expect(new_suggested_meal_2).to eq suggested_meal_2
    expect(new_suggested_meal_3).to eq suggested_meal_3
  end
end
