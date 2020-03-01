class MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html { @meals = Meal.includes(:user).meals_for(current_user) }
      format.json do
         if params.fetch(:term, "").empty?
           @autocomplete_meals = Meal.meals_for(current_user).
             select("id as value", "name as label").order(label: :asc).all
         else
           @autocomplete_meals = Meal.meals_for(current_user).
             search(params[:term]).
             select("id as value", "name as label").order(label: :desc)
         end
         render json: @autocomplete_meals
       end
     end
  end

  def show
  end

  def new
    @meal = Meal.new
  end

  def create
    @meal = Meal.new(meal_params)
    unless meal_params[:global_meal] == '1' && current_user.user_type == 'admin'
      @meal.user = current_user
    end

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
      if current_user.user_type != 'admin' and @meal.user != current_user
        redirect_to meals_path, notice: 'Unauthorized Action'
        return
      end
      if @meal.update(meal_params)
        if current_user.user_type == 'admin'
          if meal_params[:global_meal] == '1'
            @meal.user = nil
          else
            @meal.user = current_user
          end
        end
        format.html { redirect_to @meal, notice: 'Meal was successfully updated.' }
        format.json { render :show, status: :ok, location: @meal }
      else
        format.html { render :edit }
        format.json { render json: @meal.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @meal.user == current_user || current_user.user_type == 'admin'
      @meal.destroy
      respond_to do |format|
        format.html { redirect_to meals_path, notice: 'Meal was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to meals_path, alert: 'Unable to remove meal.' }
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_meal
    @meal = Meal.meals_for(current_user).find(params[:id])
    @meal.global_meal = true if @meal.user.nil?
  rescue ActiveRecord::RecordNotFound
    redirect_to meals_path, alert: "Meal not found"
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meal_params
    params.require(:meal).permit(:name, :global_meal)
  end
end
