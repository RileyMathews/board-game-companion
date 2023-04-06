class PlayController < ApplicationController
  before_action :authenticate_user!
  before_action :populate_game_data
  before_action :authorize

  def index; end

  def roll
    die = @dice.find params[:die_id]
    rolls = die.roll number: params[:number]
    roll_results = rolls.map { |face| { face: face, roll_log: @roll_log } }
    RollResult.create! roll_results

    redirect_to room_play_url(@room)
  end

  def archive_rolls
    room = Room.find params[:room_id]
    roll_log = RollLog.find_by(room: room, user: current_user)
    RollResult.where(roll_log: roll_log).update_all(archived: true) # rubocop:disable Rails/SkipsModelValidations

    redirect_to room_play_url(room)
  end

  private

  def populate_game_data
    @room = Room.find(params[:room_id])
    @game = @room.game
    @dice = @game.dice
    @roll_log = RollLog.find_or_create_by(room: @room, user: current_user)
    @roll_results = @roll_log.roll_results.where(archived: false).order(created_at: :desc).includes(:face)
    @roll_summary = @roll_log.summary
    @roll_options = 1..10
  end

  def authorize
    authorize! :play, @room
  end

  def current_ability
    @current_ability ||= PlayAbility.new current_user
  end
end
