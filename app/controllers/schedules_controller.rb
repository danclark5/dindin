class SchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  
  def index
    @schedules = Schedule.where(user_id: current_user).all.order(start_date: :desc)
  end

  def show
  end

  def new
   @schedule = Schedule.new
  end

  def edit
  end

  def create
    @schedule = Schedule.new(schedule_params)
    @schedule.user = current_user

    if @schedule.save
      create_scheduled_meals if params[:schedule][:populate_schedule]
      redirect_to @schedule 
    else 
      render :new
    end
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to @schedule
    else
      render :edit
    end
  end

  private

    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params
      params.require(:schedule).permit(:start_date, :end_date, :default_participant_count)
    end

    def create_scheduled_meals
      return nil if @schedule.included_dates.empty?
      suggested_meals = Meal.get_suggested_meals(@schedule.included_dates.length)
      @schedule.included_dates.each_with_index do |included_date, index|
        break if index >= suggested_meals.length
        ScheduledMeal.new(meal_id: suggested_meals[index].id,
                          date: included_date,
                          schedule: @schedule,
                          user: current_user).save
      end
    end
end
