class Schedule < ApplicationRecord
  validates :start_date, :end_date, :default_participant_count, presence: true
  validates_inclusion_of :include_breakfast, :include_lunch, :include_dinner, in: [true, false]

  def included_dates
    (self.start_date..self.end_date).to_a
  end
end
