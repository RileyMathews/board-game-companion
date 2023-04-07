class HomeController < ApplicationController
  def index
    @active_rooms = if user_signed_in?
                      current_user.rooms
                    else
                      []
                    end
  end
end
