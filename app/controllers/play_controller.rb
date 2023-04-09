class PlayController < ApplicationController
  before_action :authenticate_user!

  # rubocop:disable Metrics/AbcSize
  def index
    user_room = UserRoom.eager_load(:user_room_resources, room: { game: :dice })
                        .find_by(room_id: params[:room_id], user: current_user)
    @room = user_room.room
    authorize! :play, @room

    @game = @room.game
    @dice = @game.dice
    @roll_log = RollLog.find_or_create_by(room: @room, user: current_user)
    @roll_results = @roll_log.roll_results.eager_load(:face).where(archived: false).order(created_at: :desc)
    @roll_summary = @roll_log.summary
    @roll_options = 1..10
    @resources_by_group = user_room.resources_by_group
  end

  def roll
    roll_log = RollLog.find_by(room_id: params[:room_id], user: current_user)
    die = Die.find params[:die_id]
    rolls = die.roll number: params[:number]
    roll_results = rolls.map { |face| { face_id: face.id, roll_log_id: roll_log.id } }
    RollResult.insert_all! roll_results # rubocop:disable Rails/SkipsModelValidations

    roll_counts = rolls.each_with_object(Hash.new(0)) { |face, counts| counts[face.name] += 1 }
    roll_counts_string = roll_counts.map { |name, count| "#{name}: #{count}" }.join(" | ")

    redirect_to room_play_url(params[:room_id]), notice: roll_counts_string
  end

  def archive_rolls
    roll_log = RollLog.find_by(room_id: params[:room_id], user: current_user)
    RollResult.where(roll_log: roll_log, archived: false).update_all(archived: true) # rubocop:disable Rails/SkipsModelValidations

    redirect_to room_play_url(params[:room_id])
  end
  # rubocop:enable Metrics/AbcSize

private

  def current_ability
    @current_ability ||= PlayAbility.new current_user
  end
end
