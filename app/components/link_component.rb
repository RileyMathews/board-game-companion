# frozen_string_literal: true

class LinkComponent < ViewComponent::Base
  def initialize(text:, url:, data: {})
    @text, = text
    @url = url
    @data = data
  end
end
