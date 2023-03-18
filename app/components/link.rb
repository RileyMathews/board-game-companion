# frozen_string_literal: true

class Link < ViewComponent::Base
  def initialize(text:, url:, data: {})
    @text, = text
    @url = url
    @data = data
  end
end
