module Board
  module Room
    class Detail < ViewComponent::Base
      def initialize(room:)
        @room = room
      end
    end
  end
end
