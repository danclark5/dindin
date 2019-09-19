require 'pry'
class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]
  
  def index
    @schedules = Schedule.all
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

    if @schedule.save
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
      params.require(:schedule).permit(:start_date, :end_date, :include_breakfast, :include_lunch, :include_dinner, :default_participant_count)
    end
end
