class IngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  def index
    @ingredients = Ingredient.all
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
      if @ingredient.update(ingredient_params)
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
    if current_user.user_type != 'admin'
      redirect_to root_url, notice: 'Unauthorized Action'
      return
    end
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :ingredient_category_id)
  end

  def admin?
    current_user.user_type == 'admin'
  end

  def ensure_admin
    redirect_to root_url, notice: 'Unauthorized Action' and return unless admin?
  end
end
