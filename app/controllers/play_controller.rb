class PlayController < ApplicationController
  before_action :authenticate_user!

  def index
    populate_game_data
  end

  def roll
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
      RollResult.create!(user: current_user, face: face, room: @room)
    end

    redirect_to room_play_url(@room)
  end

  private

  def populate_game_data
    @room = Room.find(params[:room_id])
    @game = @room.game
    @dice = @game.dice
    @roll_results = RollResult.where(user: current_user, room: @room)
    @roll_options = 1..10
  end
end
