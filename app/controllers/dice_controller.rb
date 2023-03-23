class DiceController < ApplicationController
  let(:game) { Game.find_by slug: params[:game_id] }
  let(:dice) { Die.all }
  let(:die) { dice.find_or_initialize_by id: params[:id] }

  def index; end

  def show; end

  def new
    die.game = game
  end

  def edit; end

  def create
    die.created_by = current_user
    die.game = game
    save
  end

  def update
    save
  end

  def destroy
    die.destroy

    respond_to do |format|
      format.turbo_stream { flash.now[:notice] = "Die was successfully destroyed."}
    end
  end

  private

  def save
    respond_to do |format|
      if die.update(secure_params)
        format.turbo_stream { flash.now[:notice] = "Die was successfully saved." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def secure_params
    params.require(:die).permit(:name)
  end
end
