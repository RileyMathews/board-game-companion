class PlayController < ApplicationController
  before_action :authenticate_user!

  def index
    user_room = UserRoom.eager_load(:user_room_resources, room: { game: :dice })
                        .find_by(room_id: params[:room_id], user: current_user)
    authorize! :manage, user_room
    @room = user_room.room

    @dice = @room.game.dice
    roll_log = RollLog.find_or_create_by(user_room: user_room)
    @rolls = roll_log.rolls.where(archived: false)
    @roll_options = 1..10
    @resources_by_group = user_room.resources_by_group
  end

  def roll
    user_room = UserRoom.find_by(room_id: params[:room_id], user: current_user)
    authorize! :manage, user_room
    roll_log = RollLog.find_by(user_room: user_room)
    Die.find(params[:die_id]).roll roll_log: roll_log, number: params[:number]

    redirect_to room_play_url(user_room.room)
  end

  def archive_roll
    roll = Roll.find params[:roll_id]
    authorize! :manage, roll
    roll.update! archived: true

    redirect_to room_play_url(roll.roll_log.user_room.room)
  end
end
