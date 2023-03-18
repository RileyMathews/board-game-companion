# frozen_string_literal: true

class LinkButton < ViewComponent::Base
  def initialize(text:, href:, data: {})
    @text = text
    @href = href
    @data = data
  end
end
