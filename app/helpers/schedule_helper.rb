module ScheduleHelper
  def link_to_add_or_edit_meal schedule, date, meal_type
    scheduled_meal = schedule.meal_for(date, meal_type)
    return link_to('add meal', new_scheduled_meal_path(date: date, meal_type_id: meal_type, schedule_id: schedule.id)) unless scheduled_meal
    link_to(scheduled_meal&.meal&.name, edit_scheduled_meal_path(scheduled_meal.id))
  end
end
