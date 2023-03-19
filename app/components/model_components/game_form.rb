module ModelComponents
  class GameForm < ViewComponent::Base
    def initialize(game:, title:)
      @game = game
      @title = title
    end
  end
end
