class ScheduledMealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_scheduled_meal, only: [:show, :edit, :update, :destroy]

  def index
    start_date = DateTime.now.in_time_zone(current_user.preferred_timezone)
    end_date = start_date + 7.days
    @scheduled_meals = ScheduledMeal
      .joins("right join generate_series('#{start_date.strftime('%F')}', '#{end_date.strftime('%F')}', '1 day'::interval) as dates on dates = scheduled_meals.date and scheduled_meals.user_id = #{current_user.id}")
      .where("scheduled_meals.user_id = ? or scheduled_meals.user_id is null", current_user.id)
      .select("dates as schedule_date", :id, :meal_id)
      .order(schedule_date: :asc).all
  end

  def show
  end

  def new
    @meals = Meal.select("name, id").all
    @scheduled_meal = ScheduledMeal.new(set_up_scheduled_meal_params)
  end

  def edit
    @meals = Meal.select("name, id").all
  end

  def create
    @scheduled_meal = ScheduledMeal.new(scheduled_meal_params)
    @scheduled_meal.user = current_user

    respond_to do |format|
      if desired_meal && desired_meal.accessible_to_user?(current_user) && @scheduled_meal.save
        format.html { redirect_to root_path, notice: 'Scheduled meal was successfully created.' }
        format.json { render :show, status: :created, location: scheduled_meals_path }
      else
        format.html { render :new }
        format.json { render json: @scheduled_meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if desired_meal && desired_meal.accessible_to_user?(current_user) && @scheduled_meal.update(scheduled_meal_params)
        format.html { redirect_to root_path, notice: 'Scheduled meal was successfully updated.' }
        format.json { render :show, status: :ok, location: @scheduled_meal }
      else
        format.html { render :edit }
        format.json { render json: @scheduled_meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @scheduled_meal.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Scheduled meal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attach_suggested_meal
    @scheduled_meal = ScheduledMeal.new(attach_scheduled_meal_params)
    @scheduled_meal.user = current_user

    if @scheduled_meal.save
      redirect_back(fallback_location: root_path, notice: 'Scheduled meal was successfully added.')
    else
      redirect_back(fallback_location: root_path, notice: 'Something went wrong.')
    end
  end

  private

  def set_scheduled_meal
    @scheduled_meal = ScheduledMeal.find(params[:id])
    if @scheduled_meal.user != current_user
      raise ActiveRecord::RecordNotFound
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to scheduled_meals_path, alert: "Scheduled meal not found"
  end

  def desired_meal
    Meal.find(scheduled_meal_params[:meal_id])
  rescue ActiveRecord::RecordNotFound
    nil
  end

  def schedule_for_date(date)
    Schedule.where("user_id = :user_id and :date between start_date and end_date",
                   user_id: current_user.id,
                   date: date).first
  end

  def scheduled_meal_params
    params.require(:scheduled_meal).permit(:meal_id, :date)
  end

  def set_up_scheduled_meal_params
    params.permit(:date)
  end

  def attach_scheduled_meal_params
    params.require(:scheduled_meal).permit(:meal_id, :date)
  end
end
