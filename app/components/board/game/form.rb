module Board::Game
  class Form < ViewComponent::Base
    def initialize(game:, title:)
      @game = game
      @title = title
    end
  end
end
