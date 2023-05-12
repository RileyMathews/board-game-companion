class RollsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room

  def index
    authorize! :show, @room
    @rolls = @room.rolls.order(created_at: :desc)
  end

  def new
    authorize! :show, @room
    @dice = Die.where(game: @room.game)
    @roll_options = 1..10
  end

  def create
    authorize! :show, @room
    die = Die.find(create_params[:die_id])
    @roll = die.roll user: current_user, room: @room, number: create_params[:number]

    respond_to do |format|
      format.html { redirect_to room_url(@room), notice: @roll.summary_string }
      format.turbo_stream
    end
  end

private

  def set_room
    @room = Room.find params[:room_id]
  end

  def create_params
    params.permit(:die_id, :number)
  end
end
