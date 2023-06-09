class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i(new create)
  before_action :set_room, only: %i(show edit update destroy)
  authorize_resource

  # GET /rooms/1 or /rooms/1.json
  def show; end

  # GET /rooms/new
  def new
    @room = @game.rooms.build
  end

  # GET /rooms/1/edit
  def edit; end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)
    @room.game = @game
    @room.created_by = current_user

    respond_to do |format|
      if @room.save
        format.html { redirect_to room_url(@room), notice: "Room was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to room_url(@room), notice: "Room was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.html { redirect_to games_path, notice: "Room was successfully destroyed." }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:game_id, :name, :created_by_id)
  end
end
