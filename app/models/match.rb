class Match < ApplicationRecord
  belongs_to :tournament
  belongs_to :team_a, class_name: 'Team'
  belongs_to :team_b, class_name: 'Team'

  validates :team_a, :team_b, presence: true
  validates :score_a, :score_b, numericality: { only_integer: true }, allow_nil: true
end
