class AlertComponent < ViewComponent::Base

  def initialize(title:, description:, variant: nil, icon: nil)
    @title = title
    @description = description
    @variant = variant.nil? ? nil : variant.to_sym
    @icon = icon
    @variant_class= colors
  end

  def colors
    case @variant
    when nil
      "ring-border bg-muted/20 text-foreground [&>svg]:opacity-80"
    when :warning
      "ring-warning/20 bg-warning/5 text-warning [&>svg]:text-warning/80"
    when :success
      "ring-success/20 bg-success/5 text-success [&>svg]:text-success/80"
    when :destructive
      "ring-destructive/20 bg-destructive/5 text-destructive [&>svg]:text-destructive/80"
    end
  end

end
