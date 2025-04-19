class Team < ApplicationRecord
  belongs_to :tournament

  has_many :home_matches, class_name: "Match", foreign_key: :team_a_id, dependent: :destroy
  has_many :away_matches, class_name: "Match", foreign_key: :team_b_id, dependent: :destroy

  def matches
    home_matches + away_matches
  end
end
