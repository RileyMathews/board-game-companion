module ModelComponents
  class Game < ViewComponent::Base
    def initialize(game:)
      @game = game
    end
  end
end
