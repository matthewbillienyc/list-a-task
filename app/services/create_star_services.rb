class CreateStarServices
  attr_reader :star

  def initialize(star)
    @star = star
  end

  def call
    if star.starable_type == "List"
      star.starable.user.stars_total += 1
      star.starable.user.save
    elsif star.starable_type == "Task"
      star.starable.list.user.stars_total += 1
      star.starable.list.user.save
    end
  end
end
