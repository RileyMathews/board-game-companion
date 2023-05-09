class RollsController < ApplicationController
  def index
    @room = Room.find params[:room_id]
    authorize! :play, @room
    @rolls = @room.rolls
  end
end
