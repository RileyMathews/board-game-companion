class PlayController < ApplicationController
  before_action :authenticate_user!

  def index
    user_room = UserRoom.eager_load(:user_room_resources, room: { game: :dice })
                        .find_by(room_id: params[:room_id], user: current_user)
    @room = user_room.room
    authorize! :play, @room

    @dice = @room.game.dice
    roll_log = RollLog.find_or_create_by(user_room: user_room)
    @rolls = roll_log.rolls.where(archived: false)
    @roll_options = 1..10
    @resources_by_group = user_room.resources_by_group
  end

  def roll
    user_room = UserRoom.find_by(room_id: params[:room_id], user: current_user)
    roll_log = RollLog.find_by(user_room: user_room)
    die = Die.find params[:die_id]
    die.roll roll_log: roll_log, number: params[:number]

    redirect_to room_play_url(params[:room_id])
  end

  def archive_roll
    roll = Roll.find params[:roll_id]
    authorize! :archive, roll
    roll.update! archived: true

    redirect_to room_play_url(roll.roll_log.user_room.room)
  end

private

  def current_ability
    @current_ability ||= PlayAbility.new current_user
  end
end
