class Tournament < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :matches, dependent: :destroy
  def group_standings
    standings = Hash.new { |hash, key| hash[key] = Hash.new { |h, k| h[k] = default_team_stats } }

    matches.where(round: "Poules").each do |match|
      next unless match.played?

      group = match.group
      team_a = match.team_a
      team_b = match.team_b

      standings[group][team_a][:played] += 1
      standings[group][team_b][:played] += 1

      standings[group][team_a][:goals_for] += match.score_a
      standings[group][team_b][:goals_for] += match.score_b

      standings[group][team_a][:goals_against] += match.score_b
      standings[group][team_b][:goals_against] += match.score_a

      if match.score_a > match.score_b
        standings[group][team_a][:wins] += 1
        standings[group][team_b][:losses] += 1
        standings[group][team_a][:points] += 3
      elsif match.score_a < match.score_b
        standings[group][team_b][:wins] += 1
        standings[group][team_a][:losses] += 1
        standings[group][team_b][:points] += 3
      else
        standings[group][team_a][:draws] += 1
        standings[group][team_b][:draws] += 1
        standings[group][team_a][:points] += 1
        standings[group][team_b][:points] += 1
      end
    end

    standings
  end

  def default_team_stats
    {
      played: 0,
      wins: 0,
      draws: 0,
      losses: 0,
      goals_for: 0,
      goals_against: 0,
      points: 0
    }
  end

end
