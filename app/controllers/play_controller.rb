class PlayController < ApplicationController
  before_action :authenticate_user!

  def index
    @room = Room.find params[:room_id]
    authorize! :play, @room
  end
end
