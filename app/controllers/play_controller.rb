class PlayController < ApplicationController
  before_action :authenticate_user!

  def index
    populate_game_data
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def roll
    # TODO: Move this hacked up code into model method(s)
    populate_game_data
    @die = @dice.find params[:die_id]
    number_to_roll = params[:number]
    faces = @die.faces
    potential_rolls = []
    faces.each do |face|
      face.count.times do
        potential_rolls.push face
      end
    end
    number_to_roll.to_i.times do
      face = potential_rolls.sample
      RollResult.create!(face:, roll_log: @roll_log)
    end

    redirect_to room_play_url(@room)
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

  def populate_game_data
    @room = Room.find(params[:room_id])
    @game = @room.game
    @dice = @game.dice
    @roll_log = RollLog.find_or_create_by(room: @room, user: current_user)
    @roll_results = @roll_log.roll_results
    @roll_options = 1..10
  end
end
