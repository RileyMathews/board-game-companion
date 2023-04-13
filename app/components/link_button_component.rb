class LinkButtonComponent < ViewComponent::Base
  include ButtonBase

  def initialize(text:, href:, variant: :light)
    @text = text
    @href = href
    @variant = variant
    @classes = full_class_list
  end
end
