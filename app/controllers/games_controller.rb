class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_user!
  before_action :set_game, only: %i(edit update destroy)
  authorize_resource

  # GET /games or /games.json
  def index
    @games = Game.all
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit; end

  # POST /games or /games.json
  def create
    @game = Game.new(game_params)
    @game.created_by = current_user

    if @game.save
      redirect_to games_url, notice: "Game was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    if @game.update(game_params)
      redirect_to games_url, notice: "Game was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    @game.destroy

    redirect_to games_url, notice: "Game was successfully destroyed."
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:name, :created_by_id)
  end
end
