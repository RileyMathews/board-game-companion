class RoomsController < ApplicationController
  before_action :authenticate_user!
  let(:game) { Game.find_by(slug: params[:game_id]) }
  let(:rooms) { Room.all }
  let(:room) { rooms.find_or_initialize_by(slug: params[:id]) }

  # GET /rooms/1 or /rooms/1.json
  def show; end

  # GET /rooms/new
  def new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    room.game = game
    room.created_by = current_user
    room.join_code = SecureRandom.urlsafe_base64(3).upcase

    save
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    save
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    redirect_game = room.game
    room.destroy

    respond_to do |format|
      format.html { redirect_to game_url(redirect_game), notice: "Room was successfully destroyed." }
    end
  end

  private

  def save
    respond_to do |format|
      if room.update(room_params)
        format.html { redirect_to room_url(room), notice: "Room was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name, :slug, :uuid, :game_id)
  end
end
