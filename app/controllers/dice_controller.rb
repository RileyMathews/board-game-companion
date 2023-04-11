class DiceController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i(index new create)
  before_action :set_die, only: %i(edit update destroy)
  authorize_resource

  # GET /dice or /dice.json
  def index
    @dice = @game.dice
  end

  # GET /dice/new
  def new
    authorize! :manage, @game
    @die = @game.dice.build
  end

  # GET /dice/1/edit
  def edit; end

  # POST /dice or /dice.json
  def create
    authorize! :manage, @game
    @die = Die.new(die_params)
    @die.game = @game

    respond_to do |format|
      if @die.save
        format.html { redirect_to game_dice_url(@game), notice: "Die was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dice/1 or /dice/1.json
  def update
    respond_to do |format|
      if @die.update(die_params)
        format.html { redirect_to game_dice_url(@die.game), notice: "Die was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dice/1 or /dice/1.json
  def destroy
    game = @die.game
    @die.destroy

    respond_to do |format|
      format.html { redirect_to game_dice_url(game), notice: "Die was successfully destroyed." }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_die
    @die = Die.find(params[:id])
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  # Only allow a list of trusted parameters through.
  def die_params
    params.require(:die).permit(:name, :game_id)
  end
end
