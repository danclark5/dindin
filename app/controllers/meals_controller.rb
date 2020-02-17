class MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: [:show, :edit, :update, :destroy]
  before_action :redirect_non_admin, only: [:create, :update, :destroy]

  def index
    @meals = Meal.meals_for(current_user)
    if params[:term]
      @autocomplete_meals = Meal.meals_for(current_user).search(params[:term]).select("meals.id as value", "meals.name as label").order(label: :desc)
    else
      @autocomplete_meals = Meal.meals_for(current_user).select("meals.id as value", "meals.name as label").order(label: :asc).all
    end

    respond_to do |format|
       format.html
       format.json { render json: @autocomplete_meals }
     end
  end

  def show
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)

    respond_to do |format|
      if @meal.save
        format.html { redirect_to @meal, notice: 'Meal was successfully created.' }
        format.json { render :show, status: :created, location: @meal }
      else
        format.html { render :new }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @meal.update(meal_params)
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @meal.destroy
    respond_to do |format|
      format.html { redirect_to meals_path, notice: 'Meal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meal
      @meal = Meal.meals_for(current_user).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meal_params
      params.require(:meal).permit(:name)
    end

    def redirect_non_admin
      if current_user.user_type != 'admin'
        redirect_to meals_path, notice: 'Unauthorized Action'
      end
    end
end
