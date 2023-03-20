module Board
  module Room
    class Card < ViewComponent::Base
      with_collection_parameter :room

      def initialize(room:)
        @room = room
      end
    end
  end
end
