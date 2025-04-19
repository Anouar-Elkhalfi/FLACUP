class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :generate_group_stage]

  def show
  end

  def generate_group_stage
    TournamentGenerator.new(@tournament).generate_group_stage
    redirect_to @tournament, notice: "Phases de poule générées !"
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end
end
