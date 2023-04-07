class PlayController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.find(params[:room_id])
    authorize! :play, @room
    user_room = UserRoom.find_by room: @room, user: current_user
    @game = @room.game
    @dice = @game.dice
    @roll_log = RollLog.find_or_create_by(room: @room, user: current_user)
    @roll_results = @roll_log.roll_results.where(archived: false).order(created_at: :desc).includes(:face)
    @roll_summary = @roll_log.summary
    @roll_options = 1..10
    @resources = UserRoomResource.where(user_room: user_room)
  end

  def roll
    roll_log = RollLog.find_by(room_id: params[:room_id], user: current_user)
    die = Die.find params[:die_id]
    rolls = die.roll number: params[:number]
    roll_results = rolls.map { |face| { face_id: face.id, roll_log_id: roll_log.id } }
    RollResult.insert_all! roll_results # rubocop:disable Rails/SkipsModelValidations

    redirect_to room_play_url(params[:room_id])
  end

  def archive_rolls
    roll_log = RollLog.find_by(room_id: params[:room_id], user: current_user)
    RollResult.where(roll_log: roll_log, archived: false).update_all(archived: true) # rubocop:disable Rails/SkipsModelValidations

    redirect_to room_play_url(params[:room_id])
  end

private

  def current_ability
    @current_ability ||= PlayAbility.new current_user
  end
end
