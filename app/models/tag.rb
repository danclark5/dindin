class Tag < ApplicationRecord
  include PgSearch::Model

  validates :name, presence: true
  has_and_belongs_to_many :meals

  pg_search_scope :search, against: :name, using: {:tsearch => {:prefix => true}}
end
