class PlayController < ApplicationController
  before_action :authenticate_user!

  def index
    user_room = UserRoom.find_by(room_id: params[:room_id], user: current_user)
    authorize! :play, user_room
    @room = user_room.room

    @dice = @room.game.dice
    @roll_options = 1..10
    @resources_by_group = user_room.resources_by_group
    @other_players_resources = RoomResource.where(room: @room).where.not(user: current_user).joins(:user).group_by(&:user)
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
