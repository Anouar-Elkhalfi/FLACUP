class TournamentsController < ApplicationController
  before_action :set_tournament, only: [:show, :edit, :update, :destroy, :generate_group_stage]

  def index
    @tournaments = Tournament.all
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new(tournament_params)
    if @tournament.save
      redirect_to @tournament, notice: "Tournoi créé avec succès"
    else
      render :new
    end
  end

  def show
    @matches = @tournament.matches.order(:group, :round)
    @standings = @tournament.group_standings
  end

  def edit
  end

  def update
    if @tournament.update(tournament_params)
      redirect_to @tournament, notice: "Tournoi mis à jour avec succès"
    else
      render :edit
    end
  end

  def destroy
    @tournament.destroy
    redirect_to tournaments_path, notice: "Tournoi supprimé"
  end

  def generate_group_stage
    @tournament.generate_group_stage
    redirect_to @tournament, notice: "Phases de poule générées avec succès."
  rescue => e
    redirect_to @tournament, alert: e.message
  end

  private

  def set_tournament
    @tournament = Tournament.find(params[:id])
  end

  def tournament_params
    params.require(:tournament).permit(
      :title,
      :description,
      :location,
      :start_date,
      :end_date,
      :categories,
      :registration_fee,
      :accommodation_details,
      :facilities,
      :organizer_contact,
      :max_teams,
      :format,
      :extras
    )
  end
end
