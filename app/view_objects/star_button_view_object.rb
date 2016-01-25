class StarButtonViewObject
  attr_reader :starable, :star_partial, :unstar_partial

  def initialize(starable, star_partial, unstar_partial)
    @starable = starable
    @star_partial = star_partial
    @unstar_partial = unstar_partial
  end

  def call
    if starable.star.nil?
      return star_partial
    else
      return unstar_partial
    end
  end
end
