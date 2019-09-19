class Schedule < ApplicationRecord
  validates :start_date, :end_date, :include_breakfast, :include_lunch, :include_dinner, :default_participant_count, presence: true
end
