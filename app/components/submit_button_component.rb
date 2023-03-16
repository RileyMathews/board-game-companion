# frozen_string_literal: true

class SubmitButtonComponent < ViewComponent::Base
  def initialize(f:, text:)
    @f = f
    @text = text
  end

end
