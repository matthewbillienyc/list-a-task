class CreateStarServices
  attr_reader :star

  def initialize(star)
    @star = star
  end

  def call
    self.star.starable.user.stars_total += 1
    self.star.starable.user.save
  end
end
