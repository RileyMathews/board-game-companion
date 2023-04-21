class PlayController < ApplicationController
  before_action :authenticate_user!

  def index
    user_room = UserRoom.find_by(room_id: params[:room_id], user: current_user)
    authorize! :play, user_room
    @room = user_room.room

    @dice = @room.game.dice
    @rolls = Roll.where(archived: false, user: current_user, room_id: params[:room_id])
    @roll_options = 1..10
    @resources_by_group = user_room.resources_by_group
  end

  def roll
    user_room = UserRoom.find_by(room_id: params[:room_id], user: current_user)
    authorize! :play, user_room
    Die.find(params[:die_id]).roll user: current_user, room: user_room.room, number: params[:number]

    redirect_to room_play_url(user_room.room)
  end

  def archive_roll
    roll = Roll.find params[:roll_id]
    authorize! :manage, roll
    roll.update! archived: true

    redirect_to room_play_url(roll.room)
  end
end
