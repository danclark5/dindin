class MealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  def index
    respond_to do |format|
      format.html { @meals = Meal.includes(:user).meals_for(current_user).order(name: :asc) }
      format.json do
         if params.fetch(:term, "").empty?
           @meals = Meal.meals_for(current_user).
             select("meals.id as value", "meals.name as label").order(label: :asc).all
         else
           direct_meals = Meal.meals_for(current_user).
             search(params[:term]).
             select("meals.id as value", "meals.name as label").reorder("")
           tagged_meals = Tag.search(params[:term]).
             joins(:meals).
             merge(Meal.meals_for(current_user)).
             select('"meals".id as value', '"meals".name as label').reorder("")
           @meals = Meal.from("(#{direct_meals.to_sql} UNION #{tagged_meals.to_sql}) AS meals").order(label: :asc)
         end
         render json: @meals
       end
     end
  end

  def show
    @tags = Tag.all
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
          @meal.save
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
    if current_user.user_type == 'admin' || @meal&.user == current_user 
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

  def tag
    if current_user.user_type != 'admin'
      redirect_to meals_path, notice: 'Unauthorized Action'
      return
    end
    meal = Meal.find(tag_params[:meal_id])
    tag = Tag.find(tag_params[:tag_id])
    meal.tags << tag
    respond_to do |format|
      if meal.save
        format.html { redirect_to meal, notice: 'Tag added!.' }
        format.json { head :no_content }
      else
        format.html { redirect_to meal, alert: 'Unable add tag.' }
        format.json { head :no_content }
      end
    end
  end

  def untag
    if current_user.user_type != 'admin'
      redirect_to meals_path, notice: 'Unauthorized Action'
      return
    end
    meal = Meal.find(tag_params[:meal_id])
    tag = Tag.find(tag_params[:tag_id])
    meal.tags -= [tag]
    respond_to do |format|
      if meal.save
        format.html { redirect_to meal, notice: 'Tag removed!.' }
        format.json { head :no_content }
      else
        format.html { redirect_to meal, alert: 'Unable remove tag.' }
        format.json { head :no_content }
      end
    end
  end

  private
  def set_meal
    @meal = Meal.meals_for(current_user).find(params[:id])
    @meal.global_meal = true if @meal.user.nil?
  rescue ActiveRecord::RecordNotFound
    redirect_to meals_path, alert: "Meal not found"
  end

  def meal_params
    params.require(:meal).permit(:name, :recipe_url, :global_meal)
  end

  def tag_params
    params.permit(:meal_id, :tag_id)
  end
end
