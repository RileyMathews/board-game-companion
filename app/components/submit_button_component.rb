class SubmitButtonComponent < ViewComponent::Base
  include ButtonBase

  def initialize(text:, variant: :default)
    @text = text
    @variant = variant
    @classes = full_class_list
  end
end
