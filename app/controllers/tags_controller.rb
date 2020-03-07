class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :redirect_if_not_admin
  before_action :set_tag, only: [:edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to Tag, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: Tag}
      else
        format.html { render :new }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to Tag, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: Tag}
      else
        format.html { render :edit }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to Tag, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def redirect_if_not_admin
    redirect_to root_path, alert: "Not authorized" unless current_user.user_type == "admin"
  end

  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
