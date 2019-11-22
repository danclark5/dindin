class ScheduledMealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_scheduled_meal, only: [:show, :edit, :update, :destroy]

  def index
    @scheduled_meals = ScheduledMeal.all
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

    respond_to do |format|
      if @scheduled_meal.save
        format.html { redirect_to @scheduled_meal.schedule, notice: 'Scheduled meal was successfully created.' }
        format.json { render :show, status: :created, location: @scheduled_meal.schedule }
      else
        format.html { render :new }
        format.json { render json: @scheduled_meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @scheduled_meal.update(scheduled_meal_params)
        format.html { redirect_to @scheduled_meal.schedule, notice: 'Scheduled meal was successfully updated.' }
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
      format.html { redirect_to scheduled_meals_url, notice: 'Scheduled meal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scheduled_meal
      @scheduled_meal = ScheduledMeal.find(params[:id])
    end

    def scheduled_meal_params
      params.require(:scheduled_meal).permit(:meal_id, :date, :schedule_id)
    end
    def set_up_scheduled_meal_params
      params.permit(:date, :schedule_id)
    end
end
