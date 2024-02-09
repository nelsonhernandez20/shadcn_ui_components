class AspectRatioComponent < ViewComponent::Base
  def initialize(aspect_ratio:, image_path:)
    @aspect_ratio = aspect_ratio
    @image_path = image_path
  end

  def padding_bottom
    @aspect_ratio.split("/").map(&:to_f).reverse.reduce(&:fdiv) * 100
  end
end
