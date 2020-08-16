class IngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  def index
    @ingredients = Ingredient.all
    respond_to do |format|
      format.html { @ingredients = Ingredient.ingredients_for(current_user) }
      format.json do
        if params.fetch(:term, "").empty?
          @ingredients = Ingredient.ingredients_for(current_user).
            select("ingredients.id as value", "ingredients.name as label", "'' as tag").order(label: :asc).all
        else
          @ingredients = Ingredient.ingredients_for(current_user).
            search(params[:term]).
            select("ingredients.id as value", "ingredients.name as label").order(label: :asc).all
        end
        render json: @ingredients
      end
    end
  end

  def show
  end

  def new
    @ingredient = Ingredient.new
    @ingredient_categories = IngredientCategory.all
  end

  def edit
    @ingredient_categories = IngredientCategory.all
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    unless ingredient_params[:global_ingredient] == '1' && current_user.user_type == 'admin'
      @ingredient.user = current_user
    end

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient }
      else
        @ingredient_categories = IngredientCategory.all
        format.html { render :new }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if current_user.user_type != 'admin' and @ingredient.user != current_user
        redirect_to ingredients_path, notice: 'Unauthorized Action'
        return
      end
      if @ingredient.update(ingredient_params)
        if current_user.user_type == 'admin'
          if ingredient_params[:global_ingredient] == '1'
            @ingredient.user = nil
          else
            @ingredient.user = current_user
          end
        end
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient }
      else
        @ingredient_categories = IngredientCategory.all
        format.html { render :edit }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to ingredients_url, notice: 'Ingredient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_ingredient
    @ingredient = Ingredient.ingredients_for(current_user).find(params[:id])
    @ingredient.global_ingredient = true if @ingredient.user.nil?
  rescue ActiveRecord::RecordNotFound
    redirect_to ingredients_path, alert: "Ingredient not found"
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :ingredient_category_id, :global_ingredient)
  end
end
