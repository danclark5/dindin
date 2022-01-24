class SuggestedMealComponent < ViewComponent::Base
  def initialize(meal_suggestions, schedule_date)
    @meal_suggestions = meal_suggestions
    @schedule_date = schedule_date
  end
end
