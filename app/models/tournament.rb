class Tournament < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :matches, dependent: :destroy

  def generate_group_stage
    raise "Le tournoi doit avoir exactement 48 équipes" unless teams.count == 48

    groups = teams.shuffle.each_slice(8).to_a
    groups.each_with_index do |group_teams, index|
      group_letter = ("A".ord + index).chr
      group_teams.combination(2).each do |team1, team2|
        matches.create!(
          team_a: team1,
          team_b: team2,
          group: group_letter,
          round: "Poules"
        )
      end
    end
  end

  def group_standings
    standings = Hash.new { |hash, key| hash[key] = Hash.new { |h, k| h[k] = initial_stats } }

    matches.includes(:team_a, :team_b).each do |match|
      next unless match.score_a && match.score_b

      group = match.group
      team_a = match.team_a
      team_b = match.team_b
      score_a = match.score_a
      score_b = match.score_b

      update_stats(standings[group][team_a], score_a, score_b)
      update_stats(standings[group][team_b], score_b, score_a)
    end

    standings
  end

  private

  def initial_stats
    { played: 0, wins: 0, draws: 0, losses: 0, goals_for: 0, goals_against: 0, points: 0 }
  end

  def update_stats(stats, goals_for, goals_against)
    stats[:played] += 1
    stats[:goals_for] += goals_for
    stats[:goals_against] += goals_against
    if goals_for > goals_against
      stats[:wins] += 1
      stats[:points] += 3
    elsif goals_for == goals_against
      stats[:draws] += 1
      stats[:points] += 1
    else
      stats[:losses] += 1
    end
  end
end
