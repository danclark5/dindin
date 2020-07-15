class DateControlComponent < ViewComponent::Base
  def initialize(past_start_date, future_start_date)
    @past_start_date = past_start_date
    @future_start_date = future_start_date
  end
end
