class IngredientCategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin
  before_action :set_ingredient_category, only: [:show, :edit, :update, :destroy]

  def index
    @ingredient_categories = IngredientCategory.all
  end

  def show
  end

  def new
    @ingredient_category = IngredientCategory.new
  end

  def edit
  end

  def create
    @ingredient_category = IngredientCategory.new(ingredient_category_params)

    respond_to do |format|
      if @ingredient_category.save
        format.html { redirect_to @ingredient_category, notice: 'Ingredient category was successfully created.' }
        format.json { render :show, status: :created, location: @ingredient_category }
      else
        format.html { render :new }
        format.json { render json: @ingredient_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ingredient_category.update(ingredient_category_params)
        format.html { redirect_to @ingredient_category, notice: 'Ingredient category was successfully updated.' }
        format.json { render :show, status: :ok, location: @ingredient_category }
      else
        format.html { render :edit }
        format.json { render json: @ingredient_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ingredient_category.destroy
    respond_to do |format|
      format.html { redirect_to ingredient_categories_url, notice: 'Ingredient category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_ingredient_category
    @ingredient_category = IngredientCategory.find(params[:id])
  end

  def ingredient_category_params
    params.require(:ingredient_category).permit(:name, :icon_identifier, :accent_color)
  end

  def admin?
    current_user.user_type == 'admin'
  end

  def ensure_admin
    redirect_to root_url, notice: 'Unauthorized Action' and return unless admin?
  end
end
