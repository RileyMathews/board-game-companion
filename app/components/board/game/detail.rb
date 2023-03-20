module Board::Game
  class Detail < ViewComponent::Base
    with_collection_parameter :game

    def initialize(game:)
      @game = game
    end
  end
end
