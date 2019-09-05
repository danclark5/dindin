class ScheduledMealsController < ApplicationController
  before_action :set_scheduled_meal, only: [:show, :edit, :update, :destroy]

  # GET /scheduled_meals
  # GET /scheduled_meals.json
  def index
    @scheduled_meals = ScheduledMeal.all
  end

  # GET /scheduled_meals/1
  # GET /scheduled_meals/1.json
  def show
  end

  # GET /scheduled_meals/new
  def new
    @scheduled_meal = ScheduledMeal.new
  end

  # GET /scheduled_meals/1/edit
  def edit
  end

  # POST /scheduled_meals
  # POST /scheduled_meals.json
  def create
    @scheduled_meal = ScheduledMeal.new(scheduled_meal_params)

    respond_to do |format|
      if @scheduled_meal.save
        format.html { redirect_to @scheduled_meal, notice: 'Scheduled meal was successfully created.' }
        format.json { render :show, status: :created, location: @scheduled_meal }
      else
        format.html { render :new }
        format.json { render json: @scheduled_meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scheduled_meals/1
  # PATCH/PUT /scheduled_meals/1.json
  def update
    respond_to do |format|
      if @scheduled_meal.update(scheduled_meal_params)
        format.html { redirect_to @scheduled_meal, notice: 'Scheduled meal was successfully updated.' }
        format.json { render :show, status: :ok, location: @scheduled_meal }
      else
        format.html { render :edit }
        format.json { render json: @scheduled_meal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scheduled_meals/1
  # DELETE /scheduled_meals/1.json
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def scheduled_meal_params
      params.require(:scheduled_meal).permit(:meal_id, :date, :meal_type_id)
    end
end
