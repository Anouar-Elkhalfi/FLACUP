class TeamsController < ApplicationController
  before_action :set_tournament
  before_action :set_team, only: [:edit, :update, :destroy]

  def new
    @team = @tournament.teams.new
  end

  def create
    @team = @tournament.teams.build(team_params)
    if @team.save
      redirect_to @tournament, notice: "Équipe ajoutée avec succès"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to @tournament, notice: "Équipe mise à jour"
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to @tournament, notice: "Équipe supprimée"
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:tournament_id])
  end

  def set_team
    @team = @tournament.teams.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end
