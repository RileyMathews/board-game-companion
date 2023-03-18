class RoomsController < ApplicationController
  let(:room) { Room.find_by(slug: params[:id]) }
  let(:game) { Game.find_by(slug: params[:game_id]) }
  let(:rooms) { game.rooms }

  # GET /rooms or /rooms.json
  def index
  end

  # GET /rooms/1 or /rooms/1.json
  def show; end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
    @room = room
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    @room.game = game
    @room.created_by = current_user
    @room.join_code = SecureRandom.urlsafe_base64(3).upcase

    respond_to do |format|
      if @room.save
        format.html { redirect_to game_room_url(game, @room), notice: "Room was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if room.update(room_params)
        format.html { redirect_to game_room_url(game, room), notice: "Room was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    room.destroy

    respond_to do |format|
      format.html { redirect_to game_rooms_url(game), notice: "Room was successfully destroyed." }
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:name, :slug, :uuid, :game_id)
  end
end
