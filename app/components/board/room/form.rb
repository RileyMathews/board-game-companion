module Board::Room
  class Form < ViewComponent::Base
    def initialize(room:, game:)
      @room = room
      @game = game
    end
  end
end
