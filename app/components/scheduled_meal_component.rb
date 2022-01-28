class ScheduledMealComponent < ViewComponent::Base
  def initialize(scheduled_meal, schedule_date)
    @scheduled_meal = scheduled_meal
    @schedule_date = schedule_date
  end
end
