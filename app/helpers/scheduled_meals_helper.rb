module ScheduledMealsHelper
  def link_to_add_or_edit_meal scheduled_meal 
    return link_to('add meal', new_scheduled_meal_path(date: scheduled_meal.schedule_date)) unless scheduled_meal.id 
    link_to(scheduled_meal&.meal&.name, edit_scheduled_meal_path(scheduled_meal.id))
  end
end
