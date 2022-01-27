class MealSchedule
  def initialize (user:)
    @user = user
  end

  def generate(from_date: Date.today, days:)
    to_date = end_date_of_schedule(days: days, from: from_date)
    scheduled_meals = upcoming_scheduled_meals_by_date_range(from_date: from_date, to_date: to_date)
    schedule = scheduled_meals.map { |sm| OpenStruct.new(date: sm.date, meal: sm) }

    dates_scheduled = scheduled_meals.map { |sm| sm.date }
    dates_unscheduled = (from_date..to_date).select { |d| !dates_scheduled.include?(d) }

    if dates_unscheduled.present?
      suggested_meals = suggest_meals(dates_unscheduled.count)
      schedule += suggested_meals.zip(dates_unscheduled).map { |sgm| OpenStruct.new(date: sgm[1], suggestions: [sgm[0]]) }
    end

    schedule.sort_by(&:date)
  end

  private def upcoming_scheduled_meals_by_date_range(from_date:, to_date:)
    ScheduledMeal
      .joins(:meal)
      .where("scheduled_meals.user_id = ?", @user.id)
      .where('scheduled_meals.date BETWEEN ? AND ?', from_date.beginning_of_day, to_date.end_of_day)
      .select(:date, :id, :meal_id, "meals.name as meal_name")
      .order(date: :asc)
  end

  private def end_date_of_schedule(days:, from:)
    from + days - 1
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

  def push_out(as_of_date:)
    upcoming_scheduled_meals =  upcoming_scheduled_meals_from_date(as_of_date)

    return if upcoming_scheduled_meals.empty? || as_of_date != upcoming_scheduled_meals.first.date
    # it'd be nice to raise an error here to show that the upcoming_scheduled_meals can't be adjusted for one reason or
    # another
    end_date = schedule_block_end_date(upcoming_scheduled_meals)

    ScheduledMeal
      .where(user: @user)
      .where('date BETWEEN ? AND ?', as_of_date.beginning_of_day, end_date.end_of_day)
      .update_all("date = date + INTERVAL '1 day'")
  end

  private def upcoming_scheduled_meals_from_date(as_of_date)
    ScheduledMeal
      .where(user: @user)
      .where("date >= ?", as_of_date)
      .order(date: :asc)
  end

  private def schedule_block_end_date(schedule)
    end_date = schedule.first.date
    schedule.each_cons(2) do |meal_pair|
      break if meal_pair.first.date != meal_pair.last.date - 1
      end_date = meal_pair.last.date
    end
    return end_date
  end
end
