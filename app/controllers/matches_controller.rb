class MatchesController < ApplicationController
  before_action :set_match, only: [:update]

  def update
    if @match.update(match_params)
      redirect_to tournament_path(@match.tournament), notice: "Score mis à jour !"
    else
      redirect_to tournament_path(@match.tournament), alert: "Erreur lors de la mise à jour du score."
    end
  end

  private

  def set_match
    @match = Match.find(params[:id])
  end

  def match_params
    params.require(:match).permit(:score_a, :score_b)
  end
end
