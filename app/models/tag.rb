class Tag < ApplicationRecord
  include PgSearch::Model

  validates :name, presence: true
  has_and_belongs_to_many :meals, dependent: :destroy

  pg_search_scope :search, against: :name, using: {:tsearch => {:prefix => true}}
end
