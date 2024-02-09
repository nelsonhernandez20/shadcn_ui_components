# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  VARIANTS = {
    primary: "whitespace-nowrap inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 bg-primary text-primary-foreground shadow hover:bg-primary/90",
    secondary: "whitespace-nowrap inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 bg-secondary text-secondary-foreground hover:bg-opacity-80",
    link: "whitespace-nowrap inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 text-primary underline-offset-4 hover:underline",
    destructive: "whitespace-nowrap inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 bg-destructive text-destructive-foreground shadow-sm hover:bg-destructive/90",
    outline: "whitespace-nowrap inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 border border-input bg-background shadow-sm hover:bg-accent hover:text-accent-foreground",
    ghost: "whitespace-nowrap inline-flex items-center justify-center rounded-md font-medium transition-colors focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:pointer-events-none disabled:opacity-50 hover:bg-accent hover:text-accent-foreground"
  }

  def initialize(variant: :primary, size: :md, icon: nil)
    @size = size
    @size_classes = size_classes
  end

  # private

  def size_classes
    if @icon
      case @size
      when :sm then "h-6 w-6"
      when :md then "h-9 w-9"
      when :lg then "h-10 w-10"
      when :xl then "h-12 w-12"
      end
    else
      case @size
      when :sm then "px-3 py-1.5 h-8 text-xs"
      when :md then "px-4 py-2 h-9 text-sm"
      when :lg then "px-4 py-2 h-10 text-base"
      when :xl then "px-6 py-3 h-12 text-base"
      end
    end
  end
end
