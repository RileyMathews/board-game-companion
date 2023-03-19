module ModelComponents
  class GameForm < ViewComponent::Base
    def initialize(game:)
      @game = game
    end
  end
end