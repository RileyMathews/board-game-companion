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
        potential_rolls.push face.name
      end
    end
    @roll_detail = {}
    number_to_roll.to_i.times do
      roll = potential_rolls.sample
      if @roll_detail.key? roll
        @roll_detail[roll] += 1
      else
        @roll_detail[roll] = 1
      end
    end

    render :index, status: 206
  end

  private

  def populate_game_data
    @room = Room.find(params[:room_id])
    @game = @room.game
    @dice = @game.dice
    @roll_options = 1..10
  end
end
