class AlertDialogComponent < ViewComponent::Base
  def initialize(trigger_text:, title:, description:, cancel_text:, action_text:)
    @trigger_text = trigger_text
    @title = title
    @description = description
    @cancel_text = cancel_text
    @action_text = action_text
  end
end
