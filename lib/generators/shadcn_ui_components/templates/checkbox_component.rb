class CheckboxComponent < ViewComponent::Base
  def initialize(id:, checked: false, label:, description: nil)
    @id = id
    @checked = checked
    @label = label
    @description = description
  end
end
