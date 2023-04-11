class HomeController < ApplicationController
  skip_authorization_check

  def index
    @active_rooms = if user_signed_in?
                      current_user.rooms
                    else
                      []
                    end
  end
end
