class PlayController < ApplicationController
  before_action :authenticate_user!

  def index
    # TODO: see if this can be broken up into components via lazy loaded turbo frames?
    user_room = UserRoom.find_by(room_id: params[:room_id], user: current_user)
    authorize! :play, user_room
    @room = user_room.room

    @dice = @room.game.dice
    @roll_options = 1..10
    @all_rolls = Roll.for_room_log(@room)
  end

  def roll # rubocop:disable Metrics/AbcSize
    user_room = UserRoom.find_by(room_id: params[:room_id], user: current_user)
    authorize! :play, user_room
    @roll = Die.find(params[:die_id]).roll user: current_user, room: user_room.room, number: params[:number]

    respond_to do |format|
      format.html { redirect_to room_play_url(user_room.room), notice: @roll.summary_string }
      format.turbo_stream
    end
  end
end
