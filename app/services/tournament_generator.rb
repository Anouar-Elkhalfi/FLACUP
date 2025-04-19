class TournamentGenerator
  def initialize(tournament)
    @tournament = tournament
  end

  def generate_group_stage
    return if @tournament.matches.where(round: "Poules").any?

    groups = @tournament.teams.shuffle.each_slice(4).to_a
    group_names = ("A".."Z").to_a

    groups.each_with_index do |group_teams, index|
      group_name = group_names[index]
      group_teams.combination(2).each do |team_a, team_b|
        Match.create!(
          tournament: @tournament,
          team_a: team_a,
          team_b: team_b,
          group: group_name,
          round: "Poules"
        )
      end
    end
  end
end
