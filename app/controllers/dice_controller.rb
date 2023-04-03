class DiceController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i(index new create)
  before_action :set_die, only: %i(show edit update destroy)
  authorize_resource

  # GET /dice or /dice.json
  def index
    @can_create_die = can?(:create, Die.new(game: @game))
    @dice = @game.dice
  end

  # GET /dice/1 or /dice/1.json
  def show; end

  # GET /dice/new
  def new
    @die = @game.dice.build
    authorize! :new, @die
  end

  # GET /dice/1/edit
  def edit; end

  # POST /dice or /dice.json
  def create
    @die = Die.new(die_params)
    @die.game = @game
    authorize! :create, @die

    respond_to do |format|
      if @die.save
        format.html { redirect_to die_url(@die), notice: "Die was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dice/1 or /dice/1.json
  def update
    respond_to do |format|
      if @die.update(die_params)
        format.html { redirect_to die_url(@die), notice: "Die was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dice/1 or /dice/1.json
  def destroy
    @die.destroy

    respond_to do |format|
      format.html { redirect_to dice_url, notice: "Die was successfully destroyed." }
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

  def current_ability
    @current_ability ||= DieAbility.new(current_user)
  end
end
