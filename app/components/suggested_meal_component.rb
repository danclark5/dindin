class SuggestedMealComponent < ViewComponent::Base
  def initialize(suggested_meal, schedule_date)
    @suggested_meal = suggested_meal
    @schedule_date = schedule_date
  end
end
