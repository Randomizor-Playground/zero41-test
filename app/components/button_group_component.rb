# frozen_string_literal: true

class ButtonGroupComponent < ViewComponent::Base
  def initialize(buttons:, active_state: "open")
    @buttons = buttons
    @active_state = active_state
  end

  def active_class(state)
    if state == @active_state
      "text-blue-700 border-blue-700"
    else
      "text-gray-500 hover:text-blue-700"
    end
  end

  def rounded_class(index)
    if index == 0
      "rounded-s-lg"
    elsif index == @buttons.size - 1
      "rounded-e-lg"
    else
      ""
    end
  end
end
