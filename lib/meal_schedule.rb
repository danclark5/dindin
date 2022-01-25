class MealSchedule
  def initialize (days:, from_date: Date.today, user:)
    @days = days
    @from_date = from_date
    @to_date = end_date_of_schedule(days: days, from: from_date)
    @user = user
  end

  def generate
    scheduled_meals = upcoming_scheduled_meals
    schedule = scheduled_meals.map { |sm| OpenStruct.new(date: sm.date, meal: sm) }

    dates_scheduled = scheduled_meals.map { |sm| sm.date }
    dates_unscheduled = (@from_date..@to_date).select { |d| !dates_scheduled.include?(d) }

    if dates_unscheduled.present?
      suggested_meals = suggest_meals(dates_unscheduled.count)
      schedule += suggested_meals.zip(dates_unscheduled).map { |sgm| OpenStruct.new(date: sgm[1], suggestions: [sgm[0]]) }
    end

    schedule.sort_by(&:date)
  end

  def upcoming_scheduled_meals
    ScheduledMeal
      .joins(:meal)
      .where("scheduled_meals.user_id = ? or scheduled_meals.user_id is null", @user.id)
      .where('scheduled_meals.date BETWEEN ? AND ?', @from_date.beginning_of_day, @to_date.end_of_day)
      .select(:date, :id, :meal_id, "meals.name as meal_name")
      .order(date: :asc)
  end

  def suggest_meals(number_of_meals)
    # This should go in it's own class. MealSchedule shouldn't be responsible for meal suggestions
    meals = Meal.meals_for(@user).
      joins("left join scheduled_meals on scheduled_meals.meal_id = meals.id and scheduled_meals.user_id = users.id and scheduled_meals.created_at > current_date - 45").
      joins("left join meal_suggestion_logs on meal_suggestion_logs.meal_id = meals.id and meal_suggestion_logs.user_id = users.id and meal_suggestion_logs.created_at > current_date - 45").
      group(:id).
      select(:id, :name).
      order(Arel.sql("(COUNT(scheduled_meals.meal_id) + COUNT(meal_suggestion_logs.meal_id) + random()*10) ASC")).
      limit(number_of_meals).all.shuffle

    MealSuggestionLog.create(meals.map { |meal| {meal_id: meal.id, user_id: @user.id} })
    meals
  end

  private

  def end_date_of_schedule(days:, from:)
    from + days - 1
  end

  def needed_suggested_meals(days, scheduled_meal_count)
    if scheduled_meal_count > days
      return 0
    else
      days - scheduled_meals.length
    end
  end
end
