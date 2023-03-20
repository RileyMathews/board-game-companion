class GamesController < ApplicationController
  let(:games) { Game.ordered }
  let(:game) { games.find_or_initialize_by(slug: params[:id]) }

  # GET /games or /games.json
  def index; end

  # GET /games/1 or /games/1.json
  def show; end

  # GET /games/new
  def new; end

  # GET /games/1/edit
  def edit; end

  # POST /games or /games.json
  def create
    game.created_by = current_user
    save
  end

  # PATCH/PUT /games/1 or /games/1.json
  def update
    save
  end

  # DELETE /games/1 or /games/1.json
  def destroy
    game.destroy

    respond_to do |format|
      format.html { redirect_to games_url, notice: "Game was successfully destroyed." }
      format.turbo_stream { flash.now[:notice] = "Game was successfully destroyed." }
    end
  end

  private

  def save
    respond_to do |format|
      if game.update(game_params)
        format.html { redirect_to game_url(game), notice: "Game was successfully saved" }
        format.turbo_stream { flash.now[:notice] = "Game was successively saved." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # Only allow a list of trusted parameters through.
  def game_params
    params.require(:game).permit(:name, :uuid, :slug, :created_by_id)
  end
end
